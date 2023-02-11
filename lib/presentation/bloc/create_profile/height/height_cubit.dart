import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/constants/exceptions.dart';
import '../../../../data/models/status.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/repositories/data_repository.dart';

part 'height_state.dart';

class HeightCubit extends Cubit<HeightState> {
  final DataRepository db;
  final AuthRepository auth;

  HeightCubit({
    required this.db,
    required this.auth,
  }) : super(HeightState(status: Status.initial()));

  void setHeight(int height) => emit(state.copyWith(height: height));

  Future<void> accept(int height) async {
    try {
      await db.update(auth.currentUser()!.uid, {'height': height});
      emit(state.copyWith(status: Status.loaded()));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.message)));
    }
  }
}
