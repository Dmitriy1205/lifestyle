import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../../data/models/status.dart';

part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  late VideoPlayerController controller;

  VideoPlayerCubit() : super(VideoPlayerState(status: Status.initial()));

  void init(String videoUrl) {
    emit(state.copyWith(status: Status.loading()));
    try {
      controller = VideoPlayerController.network(
        videoUrl,
      )..initialize();
      emit(state.copyWith(
        status: Status.loaded(),
        controller: controller,
        isPlaying: true,
        isFullScreen: false,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }

  Future<void> playPause(bool isPlaying) async {
    !isPlaying ? controller.play() : controller.pause();
    emit(state.copyWith(isPlaying: isPlaying));
  }

  void fullScreen(bool isFullScreen) {
    isFullScreen ? landscapeMode() : setAllOrientation();
    emit(state.copyWith(isFullScreen: isFullScreen));
  }

  Future landscapeMode() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future setAllOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);
  }

  void getVideoDuration(String videoUrl) {
    controller = VideoPlayerController.network(
      videoUrl,
    );
    emit(state.copyWith(duration: controller.value.duration.toString()));
  }

  @override
  Future<void> close() {
    controller.dispose();

    return super.close();
  }
}
