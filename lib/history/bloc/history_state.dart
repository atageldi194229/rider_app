// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'history_bloc.dart';

enum HistoryStatus {
  initial,
  loading,
  populated,
  failure,
}

final class HistoryState extends Equatable {
  const HistoryState({
    required this.status,
    this.page = 0,
    this.hasMoreContent = true,
    this.content = const [],
  });

  const HistoryState.initial() : this(status: HistoryStatus.initial);

  final HistoryStatus status;
  final int page;
  final bool hasMoreContent;
  final List<HistoryItem> content;

  @override
  List<Object> get props => [
        status,
        page,
        hasMoreContent,
        content,
      ];

  HistoryState copyWith({
    HistoryStatus? status,
    int? page,
    bool? hasMoreContent,
    List<HistoryItem>? content,
  }) {
    return HistoryState(
      status: status ?? this.status,
      page: page ?? this.page,
      hasMoreContent: hasMoreContent ?? this.hasMoreContent,
      content: content ?? this.content,
    );
  }
}
