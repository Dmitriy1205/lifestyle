part of 'video_player_cubit.dart';

class VideoPlayerState extends Equatable {
  final Status? status;
  final VideoPlayerController? controller;
  final bool? isPlaying;
  final bool? isFullScreen;
  final String? duration;

  const VideoPlayerState({
    this.status,
    this.controller,
    this.isPlaying,
    this.isFullScreen,
    this.duration,
  });

  @override
  List<Object?> get props => [
        status,
        controller,
        isPlaying,
        isFullScreen,
        duration,
      ];

  VideoPlayerState copyWith({
    Status? status,
    VideoPlayerController? controller,
    bool? isPlaying,
    bool? isFullScreen,
    String? duration,
  }) {
    return VideoPlayerState(
      status: status ?? this.status,
      controller: controller ?? this.controller,
      isPlaying: isPlaying ?? this.isPlaying,
      isFullScreen: isFullScreen ?? this.isFullScreen,
      duration: duration ?? this.duration,
    );
  }
}
