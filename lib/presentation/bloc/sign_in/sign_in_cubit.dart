import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/constants/exceptions.dart';
import '../../../data/models/status.dart';
import '../../../data/repositories/auth_repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({required this.authRepository}) : super(SignInState(status: Status.initial()));
  final AuthRepository authRepository;

  Future<void> signIn(String email, String password) async {
    emit(state.copyWith(status: Status.loading()));
    try {
      await authRepository.signIn(email: email, password: password);
      emit(state.copyWith(status: Status.loaded()));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.message)));
    }
  }
  void showPass(bool isObscure) => emit(state.copyWith(isObscure: isObscure));
}
