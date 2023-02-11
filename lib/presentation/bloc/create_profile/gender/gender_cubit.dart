import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lifestyle/common/constants/exceptions.dart';

import '../../../../common/constants/constants.dart';
import '../../../../data/models/status.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/repositories/data_repository.dart';

part 'gender_state.dart';

class GenderCubit extends Cubit<GenderState> {
  final DataRepository db;
  final AuthRepository auth;

  GenderCubit({
    required this.db,
    required this.auth,
  }) : super(GenderState(status: Status.initial()));

  void setGender(Gender selectedGender) {
    String genderName;
    if (selectedGender == Gender.man) {
      genderName = 'Man';
    } else
      genderName = 'Woman';
    emit(state.copyWith(gender: selectedGender, genderName: genderName));
  }

  Future<void> accept(String gender) async {
    try {
      await db.update(auth.currentUser()!.uid, {'gender': gender});
      emit(state.copyWith(status: Status.loaded()));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.message)));
    }
  }
}
