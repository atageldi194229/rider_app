import 'package:asman_rider/exception_handler/exception_handler.dart';
import 'package:asman_rider/l10n/l10n.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExceptionHandlerView extends StatelessWidget {
  const ExceptionHandlerView({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExceptionHandlerBloc, ExceptionHandlerState>(
      listenWhen: (_, current) => current.error != null,
      listener: (context, state) {
        if (state.error != null) {
          String title = state.title;
          String content = state.content;

          if (state.dioException != null) {
            content = switch (state.dioException?.type) {
              DioExceptionType.connectionTimeout => context.l10n.networkError,
              DioExceptionType.sendTimeout => context.l10n.networkError,
              DioExceptionType.receiveTimeout => context.l10n.networkError,
              DioExceptionType.badCertificate => context.l10n.networkError,
              DioExceptionType.connectionError => context.l10n.networkError,
              DioExceptionType.cancel => context.l10n.networkError,
              DioExceptionType.unknown => context.l10n.networkError,
              DioExceptionType.badResponse => content,
              _ => content,
            };
          }

          if (state.dioException?.type == DioExceptionType.connectionTimeout) {
            content = context.l10n.dioConnectionTimeout;
          }

          showDialog(
            context: context,
            builder: (_) => ExceptionDialog(
              title: title,
              content: content,
            ),
          ).then(
            (_) => context.read<ExceptionHandlerBloc>().add(ExceptionRemoved(state.error!)),
          );
        }
      },
      child: child,
    );
  }
}
