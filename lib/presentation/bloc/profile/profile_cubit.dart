import 'package:bloc/bloc.dart';
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
      String email = auth.currentUser()!.email!;
      String dateOfCreation =
          auth.currentUser()!.metadata.creationTime.toString();
      var field = await db.getProfile(auth.currentUser()!.uid);

      emit(state.copyWith(
        status: Status.loaded(),
        email: email,
        date: dateOfCreation,
        profile: field ,
      ));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.message)));
    }
  }

  Future<void> logout() async {
    await auth.logout();
  }
}
