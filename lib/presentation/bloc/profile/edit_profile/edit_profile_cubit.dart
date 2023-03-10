import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lifestyle/data/models/status.dart';

import '../../../../common/constants/exceptions.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/repositories/data_repository.dart';
import '../../../../data/repositories/storage_repository.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final DataRepository db;
  final AuthRepository auth;
  final StorageRepository storage;
  final InternetConnectionChecker connectionChecker;

  EditProfileCubit({
    required this.db,
    required this.auth,
    required this.storage,
    required this.connectionChecker,
  }) : super(EditProfileState(status: Status.initial()));

  final TextEditingController nameController = TextEditingController();

  StreamSubscription<InternetConnectionStatus>? _subscription;

  Future<void> init(String name) async {
    emit(state.copyWith(status: Status.loading()));
    bool isConnected = await connectionChecker.hasConnection;

    _subscription = connectionChecker.onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            isConnected = true;
            emit(state.copyWith(isConnected: isConnected));
            break;
          case InternetConnectionStatus.disconnected:
            isConnected = false;
            emit(state.copyWith(isConnected: isConnected));
            break;
        }
      },
    );
    initController(name, isConnected);
  }

  Future<void> initController(String name, bool connection) async {
    nameController.text = name;

    emit(state.copyWith(
      status: Status.loaded(),
      nameController: nameController,
      isConnected: connection,
    ));
  }

  void getImage(File image) =>
      emit(state.copyWith(status: Status.loaded(), image: image));

  Future<void> updateFields(File? file, String image, String name) async {
    emit(state.copyWith(status: Status.loading()));
    try {
      var id = auth.currentUser()!.uid;
      String imageUrl;
      if (file != null) {
        String pic = await storage.upload(file, 'avatars/$id/$id.png');
        imageUrl = pic;
      } else {
        imageUrl = image;
      }

      await db.setProfile(auth.currentUser()!.uid, {'image': imageUrl});
      await db.setProfile(auth.currentUser()!.uid, {'name': name});
      emit(state.copyWith(status: Status.loaded()));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.message)));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    _subscription?.cancel();
    return super.close();
  }
}
