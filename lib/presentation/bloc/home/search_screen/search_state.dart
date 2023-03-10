part of 'search_cubit.dart';

class SearchState extends Equatable {
  final Status? status;
  final TextEditingController? controller;
  final List<Files>? files;
  final bool? isConnected;

  const SearchState({
    this.status,
    this.controller,
    this.files,
    this.isConnected,
  });

  SearchState copyWith({
    Status? status,
    TextEditingController? controller,
    List<Files>? files,
    bool? isConnected,
  }) {
    return SearchState(
      status: status ?? this.status,
      controller: controller ?? this.controller,
      files: files ?? this.files,
      isConnected: isConnected ?? this.isConnected,
    );
  }

  @override
  List<Object?> get props => [
        status,
        controller,
        files,
        isConnected,
      ];
}
