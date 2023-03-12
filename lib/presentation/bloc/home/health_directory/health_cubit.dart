import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lifestyle/data/repositories/data_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../../../data/models/files.dart';
import '../../../../data/models/status.dart';
import '../../../../data/repositories/storage_repository.dart';

part 'health_state.dart';

class HealthCubit extends Cubit<HealthState> {
  late VideoPlayerController controller;
  final InternetConnectionChecker connectionChecker;

  HealthCubit({
    required this.storage,
    required this.db,
    required this.connectionChecker,
  }) : super(HealthState(status: Status.initial(),isConnected: true)) {
    init();
  }

  final StorageRepository storage;
  final DataRepository db;
  List<Files> exercises = [];
  List<Files> thumb = [];
  StreamSubscription<InternetConnectionStatus>? _subscription;

  Future<void> init() async {
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
            emit(state.copyWith(isConnected: isConnected,));
            break;
        }
      },
    );

    await getExerciseVideos(isConnected);
  }

  Future<void> getExerciseVideos(bool connection) async {
    emit(state.copyWith(status: Status.loading()));
    try {
      List<Files> videos = await db.getFiles(source: 'video');
      List<Files> thumbnails = await db.getFiles(source: 'thumbnails');
      List<Files> articles = await db.getFiles(source: 'articles');
      List<Files> vitamins = await db.getFiles(source: 'vitamins');

      for (var i = 0; i < thumbnails.length; i++) {
        if (videos[i].name! == thumbnails[i].name!) {
          videos[i].thumbnail = thumbnails[i].path;
          emit(state.copyWith(
            status: Status.loaded(),
            files: videos,
            vitamins: vitamins,
            articles: articles,
            name: videos[0].name!,
            isPlaying: false,
            isFullScreen: false,
            isConnected: connection,
          ));
        }
      }
      if(connection){
        await initVideo(videos[0].path!, videos[0].name!);
      }

    } on Exception catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }

  Future<void> initVideo(String videoUrl, String name) async {
    emit(state.copyWith(status: Status.videoLoading()));
    try {
      controller = VideoPlayerController.network(
        videoUrl,
      )
        ..play()
        ..setLooping(true);

      await controller.initialize();
      emit(state.copyWith(
          status: Status.videoLoaded(), controller: controller, name: name));
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
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  Future<void> launch(String path) async {
    final Uri url = Uri.parse(path);
    try {
      await launchUrl(url);
      emit(state.copyWith(status: Status.loaded()));
    } on Exception catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }

  @override
  Future<void> close() {
    controller.dispose();
    _subscription?.cancel();
    return super.close();
  }
}
