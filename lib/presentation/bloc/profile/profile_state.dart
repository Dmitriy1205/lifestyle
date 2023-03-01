part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final Status? status;
  final String? date;
  final String? email;
  final ProfileModel? profile;
  final String? image;

  const ProfileState({
    this.status,
    this.date,
    this.email,
    this.profile,
    this.image,
  });

  ProfileState copyWith({
    Status? status,
    String? date,
    String? email,
    ProfileModel? profile,
    String? image,
  }) {
    return ProfileState(
      status: status ?? this.status,
      date: date ?? this.date,
      email: email ?? this.email,
      profile: profile ?? this.profile,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [
        status,
        date,
        email,
        profile,
        image,
      ];
}
