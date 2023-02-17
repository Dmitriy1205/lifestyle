part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final Status? status;
  final String? date;
  final String? email;

  const ProfileState({
    this.status,
    this.date,
    this.email,
  });

  ProfileState copyWith({
    Status? status,
    String? date,
    String? email,
  }) {
    return ProfileState(
      status: status ?? this.status,
      date: date ?? this.date,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [
        status,
        date,
        email,
      ];
}
