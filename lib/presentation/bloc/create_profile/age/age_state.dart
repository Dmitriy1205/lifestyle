part of 'age_cubit.dart';

class AgeState extends Equatable {
  final Status? status;
  final int? age;

  const AgeState({
    this.status,
    this.age,
  });

  AgeState copyWith({
    Status? status,
    int? age,
  }) {
    return AgeState(
      status: status ?? this.status,
      age: age ?? this.age,
    );
  }

  @override
  List<Object?> get props => [
        status,
        age,
      ];
}
