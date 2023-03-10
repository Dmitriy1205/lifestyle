import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../common/constants/constants.dart';
import '../../../../data/models/exercises.dart';
import '../../../../data/models/group.dart';
import '../../../../data/models/status.dart';
import '../../../../data/models/workout.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/repositories/data_repository.dart';
import '../../../../data/repositories/storage_repository.dart';

part 'edit_workout_state.dart';

class EditWorkoutCubit extends Cubit<EditWorkoutState> {
  EditWorkoutCubit({
    required this.db,
    required this.auth,
    required this.storage,
    required this.connectionChecker,
  }) : super(EditWorkoutState(status: Status.initial()));
  final DataRepository db;
  final AuthRepository auth;
  final StorageRepository storage;
  final InternetConnectionChecker connectionChecker;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController recomController = TextEditingController();
  List<Group> group = [];

  StreamSubscription<InternetConnectionStatus>? _subscription;

  Future<void> init(
    List<Group> exercises,
    String name,
    String des,
    String recom,
    String category,
  ) async {
    emit(state.copyWith(status: Status.loading()));
    bool isConnected = await connectionChecker.hasConnection;

    _subscription = connectionChecker.onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            isConnected = true;
            emit(state.copyWith(isConnected: isConnected));
            break;
          case InternetConnectionStatus.disconnected:
            isConnected = false;
            emit(state.copyWith(isConnected: isConnected));
            break;
        }
      },
    );

    await initFieleds(exercises, name, des, recom, category, isConnected);
  }

  Future<void> initFieleds(
    List<Group> exercises,
    String name,
    String des,
    String recom,
    String category,
    bool connection,
  ) async {
    WorkoutCategory workoutCategory;
    nameController.text = name;
    descController.text = des;
    recomController.text = recom;
    group = exercises;
    if (category == 'Gym') {
      workoutCategory = WorkoutCategory.gym;
    } else {
      workoutCategory = WorkoutCategory.home;
    }
    emit(state.copyWith(
      status: Status.loaded(),
      group: group,
      nameController: nameController,
      descController: descController,
      recomController: recomController,
      category: workoutCategory,
      isConnected: connection,
    ));
  }

  void getImage(File image) => emit(state.copyWith(image: image));

  void addExercise(Exercises exercise) {
    group.add(Group(
      exercise: exercise,
    ));
    emit(state.copyWith(status: Status.loaded(), group: group));
  }

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

  Future<void> editExercise(Workout workout, File? file, String image) async {
    emit(state.copyWith(status: Status.loading()));
    try {
      var id = auth.currentUser()!.uid;
      if (file != null) {
        String pic = await storage.upload(file, 'images/$id/${workout.id}.png');
        workout.image = pic;
      } else {
        workout.image = image;
      }
      var field = await db.getProfile(auth.currentUser()!.uid);
      workout.author = field.name ??
          auth.currentUser()!.displayName ??
          auth.currentUser()!.email;

      List<String?> exercisesDuration =
          workout.exercises!.map((e) => e.exercise?.duration).toList();
      List<String?> relaxDurations =
          workout.exercises!.map((e) => e.relaxTime).toList();

      exercisesDuration.removeWhere((e) => e == null);
      relaxDurations.removeWhere((e) => e == 'null' || e == null);

      List<int> excTime = exercisesDuration.map((e) => int.parse(e!)).toList();
      List<int> rlxTime = relaxDurations.map((e) => int.parse(e!)).toList();
      int sumOfEx = excTime.reduce((a, b) => a + b);
      int sumOfRlx = rlxTime.reduce((a, b) => a + b);
      int total = sumOfEx + sumOfRlx;
      var interval = timeSum(total);
      workout.interval = '${exercisesDuration.length} exercises | $interval';

      await db.setExercises(id, workout.toJson(), workout.id!);
      emit(state.copyWith(status: Status.loaded()));
    } on Exception catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }

  void setCategory(WorkoutCategory category) {
    String name;
    if (category == WorkoutCategory.gym) {
      name = 'Gym';
    } else {
      name = 'Home';
    }
    emit(state.copyWith(category: category, categoryName: name));
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
