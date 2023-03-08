part of 'search_cubit.dart';

class SearchState extends Equatable {
  final Status? status;
  final TextEditingController? controller;
  final List<Files>? files;
  final Source? source;

  const SearchState({
    this.status,
    this.controller,
    this.files,
    this.source,
  });

  SearchState copyWith({
    Status? status,
    TextEditingController? controller,
    List<Files>? files,
    Source? source,
  }) {
    return SearchState(
      status: status ?? this.status,
      controller: controller ?? this.controller,
      files: files ?? this.files,
      source: source ?? this.source,
    );
  }

  @override
  List<Object?> get props => [
        status,
        controller,
        files,
        source,
      ];
}
