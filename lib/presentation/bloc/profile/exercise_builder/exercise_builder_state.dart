part of 'exercise_builder_cubit.dart';

class ExerciseBuilderState extends Equatable {
  final Status? status;
  final List<Files>? files;
  final TextEditingController? controller;

  const ExerciseBuilderState({
    this.status,
    this.files,
    this.controller,
  });

  ExerciseBuilderState copyWith({
    Status? status,
    List<Files>? files,
    TextEditingController? controller,
  }) {
    return ExerciseBuilderState(
      status: status ?? this.status,
      files: files ?? this.files,
      controller: controller ?? this.controller,
    );
  }

  @override
  List<Object?> get props => [
        status,
        files,
        controller,
      ];
}
