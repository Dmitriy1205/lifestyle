import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:lifestyle/data/models/exercises.dart';
import 'package:lifestyle/data/models/workout.dart';
import 'package:lifestyle/data/repositories/auth_repository.dart';
import 'package:lifestyle/data/repositories/data_repository.dart';
import 'package:lifestyle/data/repositories/storage_repository.dart';

import '../../../../data/models/group.dart';
import '../../../../data/models/status.dart';

part 'create_workout_state.dart';

class CreateWorkoutCubit extends Cubit<CreateWorkoutState> {
  CreateWorkoutCubit({
    required this.db,
    required this.auth,
    required this.storage,
  }) : super(CreateWorkoutState(status: Status.initial())) {
    emit(state.copyWith(
      status: Status.loaded(),
      nameController: nameController,
      descController: descController,
      recomController: recomController,
    ));
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController recomController = TextEditingController();
  final DataRepository db;
  final AuthRepository auth;
  final StorageRepository storage;
  List<Group> group = [];

  void addExercise(Exercises exercise) {
    group.add(Group(
      exercise: exercise,
    ));
    emit(state.copyWith(status: Status.loaded(), group: group));
  }

  void getImage(File image) =>
      emit(state.copyWith(status: Status.loaded(), image: image));

  void addRelax(String relaxTime) {
    group.add(Group(relaxTime: relaxTime));
    emit(state.copyWith(status: Status.loaded(), group: group));
  }

  void deleteExercise(int index) {
    group.removeAt(index);
    emit(state.copyWith(status: Status.loaded(), group: group));
  }

  void deleteRelaxTime(int index) {
    group.removeAt(index);

    emit(state.copyWith(status: Status.loaded(), group: group));
  }

  Future<void> createExercise(Workout workout, File image) async {
    emit(state.copyWith(status: Status.loading()));
    try {
      String workoutId = UniqueKey().hashCode.toString();
      var id = auth.currentUser()!.uid;
      String pic = await storage.upload(image, 'images/$id/$workoutId.png');
      workout.author =
          auth.currentUser()!.displayName ?? auth.currentUser()!.email;
      workout.image = pic;
      workout.id = workoutId;

      List<String?> exercisesDuration =
          workout.exercises!.map((e) => e.exercise?.duration).toList();
      List<String?> relaxDurations =
          workout.exercises!.map((e) => e.relaxTime).toList();

      exercisesDuration.removeWhere((e) => e == null);
      relaxDurations.removeWhere((e) => e == null);

      List<int> excTime = exercisesDuration.map((e) => int.parse(e!)).toList();
      List<int> rlxTime = relaxDurations.map((e) => int.parse(e!)).toList();
      int sumOfEx = excTime.reduce((a, b) => a + b);
      int sumOfRlx = rlxTime.reduce((a, b) => a + b);
      int total = sumOfEx + sumOfRlx;
      var interval = timeSum(total);
      workout.interval = '${exercisesDuration.length} trainings | $interval';


      await db.setExercises(id, workout.toJson(), workout.id!);
      emit(state.copyWith(status: Status.loaded()));
    } on Exception catch (e) {

      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }

  String timeSum(int value) =>
      '${(value ~/ 60).toString().padLeft(2, '0')}:${(value % 60).toString().padLeft(2, '0')}';

  @override
  Future<void> close() {
    nameController.dispose();
    descController.dispose();
    recomController.dispose();
    return super.close();
  }
}
