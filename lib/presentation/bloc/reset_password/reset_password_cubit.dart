import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lifestyle/data/repositories/auth_repository.dart';

import '../../../common/constants/exceptions.dart';
import '../../../data/models/status.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit({required this.authRepository})
      : super(ResetPasswordState(status: Status.initial()));
  final AuthRepository authRepository;

  Future<void> send(String email) async {
    emit(state.copyWith(status: Status.loading()));
    try {
      authRepository.resetPassword(email);
      emit(state.copyWith(status: Status.loaded()));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.message)));
    }
  }
}
