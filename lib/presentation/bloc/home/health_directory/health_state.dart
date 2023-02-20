part of 'health_cubit.dart';

class HealthState extends Equatable {
  final Status? status;
  final List<Files>? files;
  final String? thumbnail;

  const HealthState({
    this.status,
    this.files,
    this.thumbnail,
  });

  HealthState copyWith({
    Status? status,
    List<Files>? files,
    String? thumbnail,
  }) {
    return HealthState(
      status: status ?? this.status,
      files: files ?? this.files,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  @override
  List<Object?> get props => [
        status,
        files,
        thumbnail,
      ];
}
