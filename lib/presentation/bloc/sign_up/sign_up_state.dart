part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final Status? status;
  final bool isPassObscure;
  final bool isConfPassObscure;

  SignUpState({
    this.status,
    this.isPassObscure = true,
    this.isConfPassObscure = true,
  });

  SignUpState copyWith({
    Status? status,
    bool? isPassObscure,
    bool? isConfPassObscure,
  }) {
    return SignUpState(
      status: status ?? this.status,
      isPassObscure: isPassObscure ?? this.isPassObscure,
      isConfPassObscure: isConfPassObscure ?? this.isConfPassObscure,
    );
  }

  @override
  List<Object?> get props => [
        status,
        isPassObscure,
        isConfPassObscure,
      ];
}
