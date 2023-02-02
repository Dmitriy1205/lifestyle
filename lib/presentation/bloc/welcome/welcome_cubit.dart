import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

import '../../../common/constants/constants.dart';

part 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  late VideoPlayerController controller;
  bool isPlaying = true;

  WelcomeCubit() : super(WelcomeState()) {
    controller = VideoPlayerController.asset(AppText.videoPath)
      ..setLooping(true)
      ..initialize().then((value) {
        controller.play();
        emit(WelcomeState(controller: controller, isPlaying: isPlaying));
      });
  }

  void _playerListener() {
    if (isPlaying != controller.value.isPlaying) {
      isPlaying = controller.value.isPlaying;
      emit(WelcomeState(controller: controller, isPlaying: isPlaying));
    }
  }

  @override
  Future<void> close() {
    controller.removeListener(_playerListener);
    controller.dispose();
    emit(const WelcomeState());
    return super.close();
  }
}
