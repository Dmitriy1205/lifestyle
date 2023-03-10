part of 'health_cubit.dart';

class HealthState extends Equatable {
  final Status? status;
  final List<Files>? files;
  final List<Files>? articles;
  final List<Files>? vitamins;
  final String? thumbnail;
  final VideoPlayerController? controller;
  final bool? isPlaying;
  final bool? isFullScreen;
  final String? name;
  final bool? isConnected;

  const HealthState({
    this.status,
    this.files,
    this.articles,
    this.vitamins,
    this.thumbnail,
    this.controller,
    this.isPlaying,
    this.isFullScreen,
    this.name,
    this.isConnected,
  });

  HealthState copyWith({
    Status? status,
    List<Files>? files,
    List<Files>? articles,
    List<Files>? vitamins,
    String? thumbnail,
    VideoPlayerController? controller,
    bool? isPlaying,
    bool? isFullScreen,
    String? name,
    bool? isConnected,
  }) {
    return HealthState(
      status: status ?? this.status,
      files: files ?? this.files,
      articles: articles ?? this.articles,
      vitamins: vitamins ?? this.vitamins,
      thumbnail: thumbnail ?? this.thumbnail,
      controller: controller ?? this.controller,
      isPlaying: isPlaying ?? this.isPlaying,
      isFullScreen: isFullScreen ?? this.isFullScreen,
      name: name ?? this.name,
      isConnected: isConnected ?? this.isConnected,
    );
  }

  @override
  List<Object?> get props => [
        status,
        files,
        articles,
        vitamins,
        thumbnail,
        controller,
        isPlaying,
        isFullScreen,
        name,
        isConnected,
      ];
}
