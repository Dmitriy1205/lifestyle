import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
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

  EditProfileCubit({
    required this.db,
    required this.auth,
    required this.storage,
  }) : super(EditProfileState(status: Status.initial()));

  final TextEditingController nameController = TextEditingController();

  Future<void> init(String name) async {
    final src = await db.isConnected();
    nameController.text = name;

    emit(state.copyWith(
      status: Status.loaded(),
      nameController: nameController,
      source: src,
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

    return super.close();
  }
}
