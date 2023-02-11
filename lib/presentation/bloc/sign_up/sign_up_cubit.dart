import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lifestyle/common/constants/exceptions.dart';
import 'package:lifestyle/data/repositories/auth_repository.dart';
import 'package:lifestyle/data/repositories/data_repository.dart';

import '../../../data/models/status.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required this.authRepository,
    required this.db,
  }) : super(SignUpState(status: Status.initial()));

  final AuthRepository authRepository;
  final DataRepository db;

  Future<void> signUp(String email, String password) async {
    emit(state.copyWith(status: Status.loading()));
    try {
      await authRepository
          .signUp(email: email, password: password)
          .then((value) => db.set(authRepository.currentUser()!.uid));
      emit(state.copyWith(status: Status.loaded()));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.message)));
    }
  }

  void showPass(bool isObscure) =>
      emit(state.copyWith(isPassObscure: isObscure));

  void showConfirmPass(bool isObscure) =>
      emit(state.copyWith(isConfPassObscure: isObscure));
}
