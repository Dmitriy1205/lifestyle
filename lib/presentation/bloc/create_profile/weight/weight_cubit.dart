import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/constants/exceptions.dart';
import '../../../../data/models/status.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/repositories/data_repository.dart';

part 'weight_state.dart';

class WeightCubit extends Cubit<WeightState> {
  final DataRepository db;
  final AuthRepository auth;

  WeightCubit({
    required this.db,
    required this.auth,
  }) : super(WeightState(status: Status.initial()));

  void setWeight(int weight) => emit(state.copyWith(weight: weight));

  Future<void> accept(int weight) async {
    try {
      await db.update(auth.currentUser()!.uid, {'weight': weight});
      emit(state.copyWith(status: Status.loaded()));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.message)));
    }
  }
}
