part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final Status? status;
  final bool isObscure;

  SignUpState({
    this.status,
    this.isObscure = true,
  });

  SignUpState copyWith({
    Status? status,
    bool? isObscure,
  }) {
    return SignUpState(
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
