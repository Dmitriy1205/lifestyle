part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final Status? status;
  final bool? isSignedIn;

  AuthState({
    this.status,
    this.isSignedIn,
  });

  AuthState copyWith({
    Status? status,
    bool? isSignedIn,
  }) {
    return AuthState(
      status: status ?? this.status,
      isSignedIn: isSignedIn ?? this.isSignedIn,
    );
  }

  @override
  List<Object?> get props => [
        status,
        isSignedIn,
      ];
}
