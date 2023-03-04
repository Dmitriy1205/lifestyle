import 'package:equatable/equatable.dart';

import '../../../data/models/status.dart';

class HomeState extends Equatable {
  final Status? status;
  final bool? isSearch;

  const HomeState({
    this.status,
    this.isSearch,
  });

  HomeState copyWith({
    Status? status,
    bool? isSearch,
  }) {
    return HomeState(
      status: status ?? this.status,
      isSearch: isSearch ?? this.isSearch,
    );
  }

  @override
  List<Object?> get props => [
        status,
        isSearch,
      ];
}
