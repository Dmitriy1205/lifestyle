import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
    required this.connectionChecker,
  }) : super(ProfileState(status: Status.initial())) {
    init();
  }

  final AuthRepository auth;
  final DataRepository db;
  final InternetConnectionChecker connectionChecker;
  StreamSubscription<InternetConnectionStatus>? _subscription;

  Future<void> init() async {
    emit(state.copyWith(status: Status.loading()));
    bool isConnected = await connectionChecker.hasConnection;
    _subscription = connectionChecker.onStatusChange.listen(
          (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            isConnected = true;
            emit(state.copyWith(isConnected: isConnected));
            break;
          case InternetConnectionStatus.disconnected:
            isConnected = false;
            emit(state.copyWith(isConnected: isConnected));
            break;
        }
      },
    );
    showFields(isConnected);
  }

  Future<void> showFields(bool connection) async {
    emit(state.copyWith(status: Status.loading()));
    try {
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
        isConnected: connection,
      ));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.message)));
    }
  }



  Future<void> logout() async {
    await auth.logout();
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
