part of 'weight_cubit.dart';

class WeightState extends Equatable {
  final Status? status;
  final int? weight;

  const WeightState({
    this.status,
    this.weight,
  });

  WeightState copyWith({
    Status? status,
    int? weight,
  }) {
    return WeightState(
      status: status ?? this.status,
      weight: weight ?? this.weight,
    );
  }

  @override
  List<Object?> get props => [
        status,
        weight,
      ];
}
