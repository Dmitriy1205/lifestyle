part of 'height_cubit.dart';

class HeightState extends Equatable {
  final Status? status;
  final int? height;

  HeightState({
    this.status,
    this.height,
  });

  HeightState copyWith({
    Status? status,
    int? height,
  }) {
    return HeightState(
      status: status ?? this.status,
      height: height ?? this.height,
    );
  }

  @override
  List<Object?> get props => [
        status,
        height,
      ];
}
