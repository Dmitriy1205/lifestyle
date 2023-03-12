import 'package:bloc/bloc.dart';
import 'package:lifestyle/data/models/status.dart';

import 'home_state.dart';


class HomeCubit extends Cubit<HomeState> {

  HomeCubit()
      : super(HomeState(status: Status.initial(), isSearch: false));

  void isSearchShow(bool isSearch) {
    emit(state.copyWith(status: Status.loaded(), isSearch: isSearch));
  }
}
