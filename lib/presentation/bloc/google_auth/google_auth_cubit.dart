import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/constants/exceptions.dart';
import '../../../data/models/status.dart';
import '../../../data/repositories/auth_repository.dart';

part 'google_auth_state.dart';

class GoogleAuthCubit extends Cubit<GoogleAuthState> {
  final AuthRepository auth;

  GoogleAuthCubit({required this.auth})
      : super(GoogleAuthState(status: Status.initial()));

  Future<void> login() async {
    emit(state.copyWith(status: Status.loading()));
    try {
      bool exist = await auth.signInWithGoogle();

      emit(state.copyWith(status: Status.loaded(), exist: exist));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.message)));
    }
  }
}
