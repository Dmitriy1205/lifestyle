part of 'welcome_cubit.dart';

class WelcomeState extends Equatable {
  final VideoPlayerController? controller;
  final bool? isPlaying;

  const WelcomeState({
    this.controller,
    this.isPlaying,
  });

  @override
  List<Object?> get props => [
        controller,
        isPlaying,
      ];

  WelcomeState copyWith({
    VideoPlayerController? controller,
    bool? isPlaying,
  }) {
    return WelcomeState(
      controller: controller ?? this.controller,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}
