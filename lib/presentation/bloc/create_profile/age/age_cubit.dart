import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/constants/exceptions.dart';
import '../../../../data/models/status.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/repositories/data_repository.dart';

part 'age_state.dart';

class AgeCubit extends Cubit<AgeState> {
  final DataRepository db;
  final AuthRepository auth;

  AgeCubit({
    required this.db,
    required this.auth,
  }) : super(AgeState(status: Status.initial()));

  void setAge(int age) => emit(state.copyWith(age: age));

  Future<void> accept(int age) async {
    try {
      await db.setProfile(auth.currentUser()!.uid, {'age': age});
      emit(state.copyWith(status: Status.loaded()));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.message)));
    }
  }
}
