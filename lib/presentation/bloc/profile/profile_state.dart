part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final Status? status;
  final String? date;
  final String? email;
  final ProfileModel? profile;

  const ProfileState({
    this.status,
    this.date,
    this.email,
    this.profile,
  });

  ProfileState copyWith({
    Status? status,
    String? date,
    String? email,
    ProfileModel? profile,
  }) {
    return ProfileState(
      status: status ?? this.status,
      date: date ?? this.date,
      email: email ?? this.email,
      profile: profile ?? this.profile,
    );
  }

  @override
  List<Object?> get props => [
        status,
        date,
        email,
        profile,
      ];
}
