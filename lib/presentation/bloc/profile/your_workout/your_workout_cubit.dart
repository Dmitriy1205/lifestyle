import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lifestyle/data/models/status.dart';
import 'package:lifestyle/data/repositories/auth_repository.dart';
import 'package:lifestyle/data/repositories/data_repository.dart';

import '../../../../data/models/workout.dart';

part 'your_workout_state.dart';

class YourWorkoutCubit extends Cubit<YourWorkoutState> {
  YourWorkoutCubit({
    required this.db,
    required this.auth,
  }) : super(YourWorkoutState(status: Status.initial()));

  final DataRepository db;
  final AuthRepository auth;

  Future<void> init() async {
    emit(state.copyWith(status: Status.loading()));
    try {
      List<Workout> workout = await db.getOwnWorkouts(auth.currentUser()!.uid);

      emit(state.copyWith(status: Status.loaded(), workout: workout));
    } on Exception catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }
}
