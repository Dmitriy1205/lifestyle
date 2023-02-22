import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lifestyle/data/repositories/data_repository.dart';

import '../../../../data/models/files.dart';
import '../../../../data/models/status.dart';
import '../../../../data/repositories/storage_repository.dart';

part 'health_state.dart';

class HealthCubit extends Cubit<HealthState> {
  HealthCubit({required this.storage, required this.db})
      : super(HealthState(status: Status.initial())) {
    getExerciseVideos();
  }

  final StorageRepository storage;
  final DataRepository db;
  List<Files> exercises = [];
  List<Files> thumb = [];

  Future<void> getExerciseVideos() async {
    emit(state.copyWith(status: Status.loading()));
    try {
      List<Files> videos = await db.getFiles(source: 'video');
      List<Files> thumbnails = await db.getFiles(source: 'thumbnails');

      for (var i = 0; i < thumbnails.length; i++) {
        if (videos[i].name! == thumbnails[i].name!) {
          videos[i].thumbnail = thumbnails[i].path;
        }
      }

      emit(state.copyWith(status: Status.loaded(), files: videos));
    } on Exception catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }
}
