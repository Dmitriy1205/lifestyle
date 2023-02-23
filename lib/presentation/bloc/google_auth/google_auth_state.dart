part of 'google_auth_cubit.dart';

class GoogleAuthState extends Equatable {
  final Status? status;
  final bool? exist;

  const GoogleAuthState({
    this.status,
    this.exist,
  });

  @override
  List<Object?> get props => [
        status,
        exist,
      ];

  GoogleAuthState copyWith({
    Status? status,
    bool? exist,
  }) {
    return GoogleAuthState(
      status: status ?? this.status,
      exist: exist ?? this.exist,
    );
  }
}
