import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:lifestyle/data/repositories/storage_repository.dart';

import '../../../../data/models/files.dart';
import '../../../../data/models/status.dart';

part 'exercise_builder_state.dart';

class ExerciseBuilderCubit extends Cubit<ExerciseBuilderState> {
  ExerciseBuilderCubit({required this.storage})
      : super(ExerciseBuilderState(status: Status.initial())) {
    getExerciseGifs();
  }

  final TextEditingController nameController = TextEditingController();
  final StorageRepository storage;
  List<Files> exercises = [];

  Future<void> getExerciseGifs() async {
    emit(state.copyWith(status: Status.loading()));
    try {
      List<Files> files = await storage.getFiles('exercises', exercises);
      emit(state.copyWith(status: Status.loaded(), files: files));
    } on Exception catch (e) {
      emit(state.copyWith(
          status: Status.error(e.toString()), controller: nameController));
    }
  }

  Future<void> searchExercise(String name) async {
    emit(state.copyWith(status: Status.loading()));
    try {
      List<Files> files = await storage.getFiles('exercises', exercises);

      if (name.isEmpty) {
        emit(state.copyWith(status: Status.loaded(), files: files));
      } else {
        List<Files> foundedExercises = files
            .where(
                (file) => file.name!.toLowerCase().contains(name.toLowerCase()))
            .toList();
        if (foundedExercises.isEmpty) {
          emit(state.copyWith(
            status: Status.error('No Match Exercises'),
          ));
        } else {
          emit(state.copyWith(
            status: Status.loaded(),
            files: foundedExercises,
          ));
        }
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    return super.close();
  }
}
