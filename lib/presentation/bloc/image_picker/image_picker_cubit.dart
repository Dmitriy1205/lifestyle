import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/status.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/storage_repository.dart';

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit({required this.auth, required this.storage})
      : super(ImagePickerState(status: Status.initial()));
  final AuthRepository auth;
  final StorageRepository storage;

  void getImage(File image) {
    emit(state.copyWith(status: Status.loading(), image: image));
    emit(state.copyWith(status: Status.loaded(), image: image));
  }
}
