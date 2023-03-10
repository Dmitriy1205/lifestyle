part of 'create_workout_cubit.dart';

class CreateWorkoutState extends Equatable {
  final List<Group>? group;
  final Status? status;
  final TextEditingController? nameController;

  final TextEditingController? descController;

  final TextEditingController? recomController;
  final File? image;
  final String? categoryName;
  final WorkoutCategory? category;
  final bool? isConnected;

  const CreateWorkoutState({
    this.status,
    this.group,
    this.nameController,
    this.descController,
    this.recomController,
    this.image,
    this.categoryName,
    this.category,
    this.isConnected,
  });

  CreateWorkoutState copyWith({
    Status? status,
    List<Group>? group,
    TextEditingController? nameController,
    TextEditingController? descController,
    TextEditingController? recomController,
    File? image,
    String? categoryName,
    WorkoutCategory? category,
    bool? isConnected,
  }) {
    return CreateWorkoutState(
      status: status ?? this.status,
      group: group ?? this.group,
      nameController: nameController ?? this.nameController,
      descController: descController ?? this.descController,
      recomController: recomController ?? this.recomController,
      image: image ?? this.image,
      categoryName: categoryName ?? this.categoryName,
      category: category ?? this.category,
      isConnected: isConnected ?? this.isConnected,
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
        isConnected,
      ];
}
