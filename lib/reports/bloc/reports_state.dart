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
  });

  const ReportsState.initial() : this(status: ReportsStatus.idle);

  final ReportsStatus status;
  final List<DailyOrder>? content;

  @override
  List<Object?> get props => [status, content];

  ReportsState copyWith({
    ReportsStatus? status,
    List<DailyOrder>? content,
  }) {
    return ReportsState(
      status: status ?? this.status,
      content: content ?? this.content,
    );
  }
}
