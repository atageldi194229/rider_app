import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:order_repository/order_repository.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  ReportsBloc({
    required OrderRepository orderRepository,
  })  : _orderRepository = orderRepository,
        super(const ReportsState.initial()) {
    on<ReportsRequested>(_onReportsRequested);
  }

  final OrderRepository _orderRepository;

  FutureOr<void> _onReportsRequested(ReportsRequested event, Emitter<ReportsState> emit) async {
    try {
      emit(state.copyWith(status: ReportsStatus.loading));

      final content = await _orderRepository.getDailyOrders(
        fromTime: event.filter?.fromTime,
        toTime: event.filter?.toTime,
      );

      emit(state.copyWith(
        status: ReportsStatus.populated,
        content: content,
        filter: event.filter,
      ));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: ReportsStatus.failure));
      addError(error, stackTrace);
    }
  }
}
