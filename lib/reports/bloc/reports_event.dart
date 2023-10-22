part of 'reports_bloc.dart';

sealed class ReportsEvent extends Equatable {
  const ReportsEvent();

  @override
  List<Object?> get props => [];
}

final class ReportsRequested extends ReportsEvent {
  final ReportsFilter? filter;

  const ReportsRequested({this.filter});

  @override
  List<Object?> get props => [filter];
}
