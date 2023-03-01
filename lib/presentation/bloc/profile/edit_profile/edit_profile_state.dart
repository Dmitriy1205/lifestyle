part of 'edit_profile_cubit.dart';

class EditProfileState extends Equatable {
  final Status? status;
  final File? image;
  final TextEditingController? nameController;

  const EditProfileState({
    this.status,
    this.image,
    this.nameController,
  });

  EditProfileState copyWith({
    final Status? status,
    File? image,
    TextEditingController? nameController,
  }) {
    return EditProfileState(
      status: status ?? this.status,
      image: image ?? this.image,
      nameController: nameController ?? this.nameController,
    );
  }

  @override
  List<Object?> get props => [
        status,
        image,
        nameController,
      ];
}
