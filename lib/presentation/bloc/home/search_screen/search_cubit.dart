import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:lifestyle/common/constants/exceptions.dart';

import '../../../../data/models/files.dart';
import '../../../../data/models/status.dart';
import '../../../../data/repositories/data_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.db})
      : super(SearchState(status: Status.initial())) {
    init();
  }

  final TextEditingController nameController = TextEditingController();
  final DataRepository db;

  Future<void> init() async {
    emit(state.copyWith(status: Status.loading()));
    try {
      final src = await db.isConnected();
      List<Files> files = await db.getAllFiles();

      emit(state.copyWith(
        status: Status.loaded(),
        controller: nameController,
        files: files,
        source: src,
      ));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }

  Future<void> searchFields(String name) async {
    emit(state.copyWith(status: Status.loading()));
    try {
      List<Files> files = await db.getAllFiles();

      if (name.isEmpty) {
        emit(state.copyWith(status: Status.loaded(), files: files));
      } else {
        List<Files> foundedFiles = files
            .where(
                (file) => file.name!.toLowerCase().contains(name.toLowerCase()))
            .toList();
        if (foundedFiles.isEmpty) {
          emit(state.copyWith(
            status: Status.error('No Match Items'),
          ));
        } else {
          emit(state.copyWith(
            status: Status.loaded(),
            files: foundedFiles,
          ));
        }
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    return super.close();
  }
}
