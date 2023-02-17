part of 'create_workout_cubit.dart';

class CreateWorkoutState extends Equatable {
  final List<Group>? group;
  final Status? status;
  final TextEditingController? nameController;

  final TextEditingController? descController;

  final TextEditingController? recomController;
  final File? image;

  const CreateWorkoutState({
    this.status,
    this.group,
    this.nameController,
    this.descController,
    this.recomController,
    this.image,
  });

  CreateWorkoutState copyWith(
      {Status? status,
      List<Group>? group,
      TextEditingController? nameController,
      TextEditingController? descController,
      TextEditingController? recomController,
      File? image}) {
    return CreateWorkoutState(
      status: status ?? this.status,
      group: group ?? this.group,
      nameController: nameController ?? this.nameController,
      descController: descController ?? this.descController,
      recomController: recomController ?? this.recomController,
      image: image ?? this.image,
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
      ];
}
