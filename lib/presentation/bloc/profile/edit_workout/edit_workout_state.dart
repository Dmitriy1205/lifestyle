part of 'edit_workout_cubit.dart';

class EditWorkoutState extends Equatable {
  final List<Group>? group;
  final Status? status;
  final TextEditingController? nameController;

  final TextEditingController? descController;

  final TextEditingController? recomController;
  final File? image;
  final String? categoryName;
  final WorkoutCategory? category;
  final Source? source;

  const EditWorkoutState({
    this.status,
    this.group,
    this.nameController,
    this.descController,
    this.recomController,
    this.image,
    this.categoryName,
    this.category,
    this.source,
  });

  EditWorkoutState copyWith({
    Status? status,
    List<Group>? group,
    TextEditingController? nameController,
    TextEditingController? descController,
    TextEditingController? recomController,
    File? image,
    String? categoryName,
    WorkoutCategory? category,
    Source? source,
  }) {
    return EditWorkoutState(
      status: status ?? this.status,
      group: group ?? this.group,
      nameController: nameController ?? this.nameController,
      descController: descController ?? this.descController,
      recomController: recomController ?? this.recomController,
      image: image ?? this.image,
      categoryName: categoryName ?? this.categoryName,
      category: category ?? this.category,
      source: source ?? this.source,
    );
  }

  @override
  List<Object?> get props => [
        status,
        group,
        nameController,
        descController,
        recomController,
        image,
        categoryName,
        category,
        source,
      ];
}
