part of 'health_cubit.dart';

class HealthState extends Equatable {
  final Status? status;
  final List<Files>? files;
  final List<Files>? articles;
  final String? thumbnail;
  final VideoPlayerController? controller;
  final bool? isPlaying;
  final bool? isFullScreen;
  final String? name;

  const HealthState({
    this.status,
    this.files,
    this.articles,
    this.thumbnail,
    this.controller,
    this.isPlaying,
    this.isFullScreen,
    this.name,
  });

  HealthState copyWith({
    Status? status,
    List<Files>? files,
    List<Files>? articles,
    String? thumbnail,
    VideoPlayerController? controller,
    bool? isPlaying,
    bool? isFullScreen,
    String? name,
  }) {
    return HealthState(
      status: status ?? this.status,
      files: files ?? this.files,
      articles: articles ?? this.articles,
      thumbnail: thumbnail ?? this.thumbnail,
      controller: controller ?? this.controller,
      isPlaying: isPlaying ?? this.isPlaying,
      isFullScreen: isFullScreen ?? this.isFullScreen,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [
        status,
        files,
        articles,
        thumbnail,
        controller,
        isPlaying,
        isFullScreen,
        name,
      ];
}
