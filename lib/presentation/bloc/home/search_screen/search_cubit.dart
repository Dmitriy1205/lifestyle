import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lifestyle/common/constants/exceptions.dart';

import '../../../../data/models/files.dart';
import '../../../../data/models/status.dart';
import '../../../../data/repositories/data_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({
    required this.db,
    required this.connectionChecker,
  }) : super(SearchState(status: Status.initial(),isConnected: true)) {
    init();
  }

  final TextEditingController nameController = TextEditingController();
  final InternetConnectionChecker connectionChecker;
  final DataRepository db;
  StreamSubscription<InternetConnectionStatus>? _subscription;

  Future<void> init() async {
    emit(state.copyWith(status: Status.loading()));
    bool isConnected = await connectionChecker.hasConnection;
    _subscription = connectionChecker.onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            isConnected = true;
            emit(state.copyWith(isConnected: isConnected,controller: nameController));
            break;
          case InternetConnectionStatus.disconnected:
            isConnected = false;
            emit(state.copyWith(isConnected: isConnected,controller: nameController));
            break;
        }
      },
    );
    showFields(!isConnected);
  }

  Future<void> showFields(bool connection) async {
    emit(state.copyWith(status: Status.loading()));
    try {
      List<Files> files = await db.getAllFiles();

      emit(state.copyWith(
        status: Status.loaded(),
        controller: nameController,
        files: files,
        isConnected: !connection,
      ));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }

  Future<void> searchFields(String name, bool connection) async {
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
            isConnected: connection,
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
    _subscription?.cancel();
    return super.close();
  }
}
