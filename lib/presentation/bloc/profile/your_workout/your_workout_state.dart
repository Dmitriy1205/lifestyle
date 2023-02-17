part of 'your_workout_cubit.dart';

class YourWorkoutState extends Equatable {
  final Status? status;
  final List<Workout>? workout;

  const YourWorkoutState({this.status, this.workout});

  YourWorkoutState copyWith({
    Status? status,
    List<Workout>? workout,
  }) {
    return YourWorkoutState(
      status: status ?? this.status,
      workout: workout ?? this.workout,
    );
  }

  @override
  List<Object?> get props => [
        status,
      ];
}
