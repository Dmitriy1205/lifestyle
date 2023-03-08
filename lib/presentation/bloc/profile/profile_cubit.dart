import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:lifestyle/common/constants/exceptions.dart';
import 'package:lifestyle/data/repositories/auth_repository.dart';
import 'package:lifestyle/data/repositories/data_repository.dart';

import '../../../data/models/profile.dart';
import '../../../data/models/status.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this.auth,
    required this.db,
  }) : super(ProfileState(status: Status.initial())) {
    init();
  }

  final AuthRepository auth;
  final DataRepository db;

  Future<void> init() async {
    emit(state.copyWith(status: Status.loading()));
    try {
      final src = await db.isConnected();

      String dateOfCreation =
          auth.currentUser()!.metadata.creationTime.toString();
      var field = await db.getProfile(auth.currentUser()!.uid);
      String email = field.name ?? auth.currentUser()!.email!;
      String image = field.image ?? auth.currentUser()!.photoURL!;

      emit(state.copyWith(
        status: Status.loaded(),
        email: email,
        image: image,
        date: dateOfCreation,
        profile: field,
        source: src,
      ));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.message)));
    }
  }

  Future<void> logout() async {
    await auth.logout();
  }
}
