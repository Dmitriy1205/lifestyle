import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lifestyle/common/constants/constants.dart';
import 'package:lifestyle/data/models/status.dart';

import '../../../../common/constants/exceptions.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/repositories/data_repository.dart';

part 'tags_state.dart';

class TagsCubit extends Cubit<TagsState> {
  final DataRepository db;
  final AuthRepository auth;

  TagsCubit({
    required this.db,
    required this.auth,
  }) : super(TagsState(tags: AppText.topics, status: Status.initial()));

  void setValue(int index, bool isTagged,Map<String, dynamic> tags) {
    tags
        .update(tags.keys.elementAt(index), (value) => isTagged);
    emit(state.copyWith(
      status: Status.loaded(),
      tags: tags,
    ));
  }

  Future<void> accept(Map<String, dynamic> topics) async {
    try {
      await db.setProfile(auth.currentUser()!.uid, {'topics': topics});
      emit(state.copyWith(status: Status.loaded()));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.message)));
    }
  }

  init(Map<String, dynamic> tags) {
    emit(state.copyWith(tags: tags, status: Status.loaded()));
  }
}
