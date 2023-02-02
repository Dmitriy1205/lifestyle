part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  final Status? status;
  final bool isObscure;

  SignInState({
    this.status,
    this.isObscure = true,
  });

  SignInState copyWith({
    Status? status,
    bool? isObscure,
  }) {
    return SignInState(
      status: status ?? this.status,
      isObscure: isObscure ?? this.isObscure,
    );
  }

  @override
  List<Object?> get props => [
        status,
        isObscure,
      ];
}
