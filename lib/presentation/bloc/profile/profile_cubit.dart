import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lifestyle/common/constants/exceptions.dart';
import 'package:lifestyle/data/repositories/auth_repository.dart';

import '../../../data/models/status.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.authRepository})
      : super(ProfileState(status: Status.initial())){
    init();
  }
  final AuthRepository authRepository;

  Future<void> init() async {
    emit(state.copyWith(status: Status.loading()));
    try {
      String email = await authRepository.currentUser()!.email!;
      String dateOfCreation =
          await authRepository.currentUser()!.metadata.creationTime.toString();
      emit(state.copyWith(
          status: Status.loaded(), email: email, date: dateOfCreation));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.message)));
    }
  }

  Future<void> logout() async {
    await authRepository.logout();
  }
}
