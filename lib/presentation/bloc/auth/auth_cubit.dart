import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifestyle/data/repositories/auth_repository.dart';

import '../../../data/models/status.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit({required this.authRepository})
      : super(AuthState(status: Status.initial())) {
    authRepository.authStateChange.listen((User? user) {
      if (user == null) {
        emit(state.copyWith(status: Status.loaded(), isSignedIn: false));
      } else {
        emit(state.copyWith(status: Status.loaded(), isSignedIn: true));
      }
    });
  }
}
