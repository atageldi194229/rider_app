// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'exception_handler_bloc.dart';

@immutable
class ExceptionHandlerState extends Equatable {
  const ExceptionHandlerState({
    this.error,
    this.title = '',
    this.content = '',
    this.dioException,
  });

  final Exception? error;
  final String title;
  final String content;
  final DioException? dioException;

  @override
  List<Object?> get props => [error, content, dioException]; // title not used, so we removed it
}
