part of 'line_status_bloc.dart';

sealed class LineStatusEvent extends Equatable {
  const LineStatusEvent();

  @override
  List<Object> get props => [];
}

final class LineStatusStarted extends LineStatusEvent {}

final class LineStatusTogglePressed extends LineStatusEvent {}
