part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final Status? status;
  final String? date;
  final String? email;
  final ProfileModel? profile;
  final String? image;
  final bool? isConnected;

  const ProfileState({
    this.status,
    this.date,
    this.email,
    this.profile,
    this.image,
    this.isConnected,
  });

  ProfileState copyWith({
    Status? status,
    String? date,
    String? email,
    ProfileModel? profile,
    String? image,
    bool? isConnected,
  }) {
    return ProfileState(
      status: status ?? this.status,
      date: date ?? this.date,
      email: email ?? this.email,
      profile: profile ?? this.profile,
      image: image ?? this.image,
      isConnected: isConnected ?? this.isConnected,
    );
  }

  @override
  List<Object?> get props => [
        status,
        date,
        email,
        profile,
        image,
        isConnected,
      ];
}
