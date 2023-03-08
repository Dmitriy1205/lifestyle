part of 'edit_profile_cubit.dart';

class EditProfileState extends Equatable {
  final Status? status;
  final File? image;
  final TextEditingController? nameController;
  final Source? source;

  const EditProfileState({
    this.status,
    this.image,
    this.nameController,
    this.source,
  });

  EditProfileState copyWith({
    final Status? status,
    File? image,
    TextEditingController? nameController,
    Source? source,
  }) {
    return EditProfileState(
      status: status ?? this.status,
      image: image ?? this.image,
      nameController: nameController ?? this.nameController,
      source: source ?? this.source,
    );
  }

  @override
  List<Object?> get props => [
        status,
        image,
        nameController,
        source,
      ];
}
