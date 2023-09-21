part of 'exception_handler_bloc.dart';

abstract class ExceptionHandlerEvent extends Equatable {
  const ExceptionHandlerEvent();

  @override
  List<Object> get props => [];
}

class ExceptionAdded extends ExceptionHandlerEvent {
  final Exception error;

  const ExceptionAdded(this.error);

  @override
  List<Object> get props => [error];
}

class ExceptionRemoved extends ExceptionHandlerEvent {
  final Exception error;

  const ExceptionRemoved(this.error);

  @override
  List<Object> get props => [error];
}
