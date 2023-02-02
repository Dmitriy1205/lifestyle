import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lifestyle/common/constants/exceptions.dart';
import 'package:lifestyle/data/repositories/auth_repository.dart';

import '../../../data/models/status.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.authRepository})
      : super(SignUpState(status: Status.initial()));
  final AuthRepository authRepository;

  Future<void> signUp(String email, String password) async {
    emit(state.copyWith(status: Status.loading()));
    try {
      await authRepository.signUp(email: email, password: password);
      emit(state.copyWith(status: Status.loaded()));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.message)));
    }
  }

  void showPass(bool isObscure) => emit(state.copyWith(isObscure: isObscure));
}
