part of 'search_cubit.dart';

class SearchState extends Equatable {
  final Status? status;
  final TextEditingController? controller;
  final List<Files>? files;

  const SearchState({
    this.status,
    this.controller,
    this.files,
  });

  SearchState copyWith({
    Status? status,
    TextEditingController? controller,
    List<Files>? files,
  }) {
    return SearchState(
      status: status ?? this.status,
      controller: controller ?? this.controller,
      files: files ?? this.files,
    );
  }

  @override
  List<Object?> get props => [
        status,
        controller,
        files,
      ];
}
