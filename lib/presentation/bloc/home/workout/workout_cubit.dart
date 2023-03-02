import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lifestyle/common/constants/constants.dart';
import 'package:lifestyle/data/repositories/data_repository.dart';

import '../../../../data/models/status.dart';
import '../../../../data/models/workout.dart';

part 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit({required this.db})
      : super(WorkoutState(status: Status.initial())) {
    getWorkouts();
  }

  final DataRepository db;

  Future<void> getWorkouts() async {
    emit(state.copyWith(status: Status.loading()));
    try {
      List<Workout> workouts = await db.getAllWorkouts();

      emit(state.copyWith(
          status: Status.loaded(), workout: workouts, value: AppText.all));
    } on Exception catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }

  Future<void> changeValue(String? value) async {
    emit(state.copyWith(status: Status.loading()));
    try {
      List<Workout> workouts = await db.getAllWorkouts();
      if (value == AppText.gym) {
        workouts.removeWhere((element) => element.category == AppText.home);
      } else if (value == AppText.home) {
        workouts.removeWhere((element) => element.category == AppText.gym);
      }

      emit(state.copyWith(
          status: Status.loaded(), value: value, workout: workouts));
    } on Exception catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }
}
