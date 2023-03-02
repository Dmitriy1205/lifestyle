part of 'workout_cubit.dart';

class WorkoutState extends Equatable {
  final Status? status;
  final List<Workout>? workout;
  final String? value;

  const WorkoutState({
    this.status,
    this.workout,
    this.value,
  });

  WorkoutState copyWith({
    Status? status,
    List<Workout>? workout,
    String? value,
  }) {
    return WorkoutState(
      status: status ?? this.status,
      workout: workout ?? this.workout,
      value: value ?? this.value,
    );
  }

  @override
  List<Object?> get props => [
        status,
        workout,
        value,
      ];
}
