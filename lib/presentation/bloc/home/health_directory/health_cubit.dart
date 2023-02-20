import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/files.dart';
import '../../../../data/models/status.dart';
import '../../../../data/repositories/storage_repository.dart';

part 'health_state.dart';

class HealthCubit extends Cubit<HealthState> {
  HealthCubit({required this.storage})
      : super(HealthState(status: Status.initial())) {
    getExerciseVideos();
  }

  final StorageRepository storage;
  List<Files> exercises = [];
  List<Files> thumb = [];

  Future<void> getExerciseVideos() async {
    emit(state.copyWith(status: Status.loading()));
    try {
      List<Files> videos = await storage.getFiles('videos', exercises);
      List<Files> thumbnails = await storage.getFiles('thumbnail', thumb);

      for (var i = 0; i < thumbnails.length; i++) {
        if (videos[i].name! == thumbnails[i].name!) {
          videos[i].thumbnail = thumbnails[i].url;
        }
      }

      emit(state.copyWith(status: Status.loaded(), files: videos));
    } on Exception catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }
}
