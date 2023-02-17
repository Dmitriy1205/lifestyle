part of 'gender_cubit.dart';

class GenderState extends Equatable {
  final Status? status;
  final Gender? gender;
  final String? genderName;

  const GenderState({
    this.status,
    this.gender,
    this.genderName,
  });

  GenderState copyWith({
    Gender? gender,
    String? genderName,
    Status? status,
  }) {
    return GenderState(
      gender: gender ?? this.gender,
      genderName: genderName ?? this.genderName,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        gender,
        genderName,
        status,
      ];
}
