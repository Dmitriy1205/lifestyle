part of 'tags_cubit.dart';

class TagsState extends Equatable {
  final bool? isTagged;
  final Status? status;
  final Map<String, dynamic>? tags;

  const TagsState({
    this.isTagged,
    this.tags,
    this.status,
  });

  TagsState copyWith({
    bool? isTagged,
    Map<String, dynamic>? tags,
    Status? status,
  }) {
    return TagsState(
      isTagged: isTagged ?? this.isTagged,
      tags: tags ?? this.tags,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        isTagged,
        tags,
        status,
      ];
}
