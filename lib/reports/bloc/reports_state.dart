// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reports_bloc.dart';

enum ReportsStatus {
  idle,

  loading,
  populated,
  failure,
}

final class ReportsState extends Equatable {
  const ReportsState({
    required this.status,
    this.content,
    this.filter = const ReportsFilter(),
  });

  const ReportsState.initial() : this(status: ReportsStatus.idle);

  final ReportsStatus status;
  final List<DailyOrder>? content;
  final ReportsFilter filter;

  @override
  List<Object?> get props => [status, content, filter];

  ReportsState copyWith({
    ReportsStatus? status,
    List<DailyOrder>? content,
    ReportsFilter? filter,
  }) {
    return ReportsState(
      status: status ?? this.status,
      content: content ?? this.content,
      filter: filter ?? this.filter,
    );
  }
}

final class ReportsFilter extends Equatable {
  final DateTime? fromTime;
  final DateTime? toTime;

  const ReportsFilter({
    this.fromTime,
    this.toTime,
  });

  @override
  List<Object?> get props => [fromTime, toTime];
}
