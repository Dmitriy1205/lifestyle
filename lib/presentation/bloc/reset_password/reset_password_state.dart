part of 'reset_password_cubit.dart';

class ResetPasswordState extends Equatable {
  final Status? status;

  ResetPasswordState({
    this.status,
  });

  ResetPasswordState copyWith({
    Status? status,
  }) {
    return ResetPasswordState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        status,
      ];
}
