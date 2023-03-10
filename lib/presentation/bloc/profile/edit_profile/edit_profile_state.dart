part of 'edit_profile_cubit.dart';

class EditProfileState extends Equatable {
  final Status? status;
  final File? image;
  final TextEditingController? nameController;
  final bool? isConnected;

  const EditProfileState({
    this.status,
    this.image,
    this.nameController,
    this.isConnected,
  });

  EditProfileState copyWith({
    final Status? status,
    File? image,
    TextEditingController? nameController,
    bool? isConnected,
  }) {
    return EditProfileState(
      status: status ?? this.status,
      image: image ?? this.image,
      nameController: nameController ?? this.nameController,
      isConnected: isConnected ?? this.isConnected,
    );
  }

  @override
  List<Object?> get props => [
        status,
        image,
        nameController,
        isConnected,
      ];
}
