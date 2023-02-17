part of 'workout_cubit.dart';

class WorkoutState extends Equatable {
  final Status? status;
  final List<Workout>? workout;

  const WorkoutState({
    this.status,
    this.workout,
  });

  WorkoutState copyWith({
    Status? status,
    List<Workout>? workout,
  }) {
    return WorkoutState(
      status: status ?? this.status,
      workout: workout ?? this.workout,
    );
  }

  @override
  List<Object?> get props => [
        status,
        workout,
      ];
}
