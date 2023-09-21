import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:order_repository/order_repository.dart';
import 'package:ride_repository/ride_repository.dart';

part 'order_lines_event.dart';
part 'order_lines_state.dart';

enum OrderLinesMode {
  readOnly,
  editable,
}

class OrderLinesBloc extends Bloc<OrderLinesEvent, OrderLinesState> {
  OrderLinesBloc({
    required int orderId,
    required int pointId,
    required OrderRepository orderRepository,
    required RideRepository rideRepository,
    OrderLinesMode? mode,
  })  : _orderId = orderId,
        _pointId = pointId,
        _orderRepository = orderRepository,
        _rideRepository = rideRepository,
        _mode = mode ?? OrderLinesMode.readOnly,
        super(const OrderLinesState.initial()) {
    on<OrderLinesRequested>(_orderLinesRequested);
    on<OrderLinesItemIncremented>(_onOrderLinesItemIncremented);
    on<OrderLinesItemDecremented>(_onOrderLinesItemDecremented);
    on<OrderLinesPointComplete>(_onPointComlete);
  }

  final int _orderId;
  final int _pointId;
  final OrderRepository _orderRepository;
  final RideRepository _rideRepository;
  final OrderLinesMode _mode;

  OrderLinesMode get mode => _mode;

  FutureOr<void> _orderLinesRequested(OrderLinesRequested event, Emitter<OrderLinesState> emit) async {
    try {
      emit(state.copyWith(status: OrderLinesStatus.loading));

      final orderLines = await _orderRepository.getOrderLines(_orderId);

      emit(state.copyWith(
        status: OrderLinesStatus.populated,
        orderLines: orderLines,
      ));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: OrderLinesStatus.failure));
      addError(error, stackTrace);
    }
  }

  bool isLineQuantityUpdatable(Line line, int value) {
    final quantity = (line.quantity ?? 0) + value;
    final returned = (line.returned ?? 0) - value;

    if (returned >= 0 && quantity >= 0) {
      return true;
    }

    return false;
  }

  FutureOr<void> _onOrderLinesItemIncremented(OrderLinesItemIncremented event, Emitter<OrderLinesState> emit) async {
    emit(state.copyWith(
      status: OrderLinesStatus.updatingItemQuantity,
      updatingLineId: event.lineId,
    ));

    try {
      final lineId = event.lineId;
      final orderId = state.orderLines!.id!;

      final line = state.orderLines!.lines!.firstWhere((line) => line.id == lineId);

      if (!isLineQuantityUpdatable(line, 1)) {
        return;
      }

      final orderLines = await _orderRepository.updateOrder(
        orderId,
        lineId,
        line.quantity! + 1,
      );

      emit(state.copyWith(
        orderLines: orderLines,
        status: OrderLinesStatus.updatingItemQuantitySucceeded,
      ));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: OrderLinesStatus.updatingItemQuantityFailure));
      addError(error, stackTrace);
    }
  }

  FutureOr<void> _onOrderLinesItemDecremented(OrderLinesItemDecremented event, Emitter<OrderLinesState> emit) async {
    emit(state.copyWith(
      status: OrderLinesStatus.updatingItemQuantity,
      updatingLineId: event.lineId,
    ));

    try {
      final lineId = event.lineId;
      final orderId = state.orderLines!.id!;

      final line = state.orderLines!.lines!.firstWhere((line) => line.id == lineId);

      if (!isLineQuantityUpdatable(line, -1)) {
        return;
      }

      final orderLines = await _orderRepository.updateOrder(
        orderId,
        lineId,
        line.quantity! - 1,
      );

      emit(state.copyWith(
        orderLines: orderLines,
        status: OrderLinesStatus.updatingItemQuantitySucceeded,
      ));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: OrderLinesStatus.updatingItemQuantityFailure));
      addError(error, stackTrace);
    }
  }

  FutureOr<void> _onPointComlete(OrderLinesPointComplete event, Emitter<OrderLinesState> emit) async {
    try {
      emit(state.copyWith(status: OrderLinesStatus.completingPoint));

      await _rideRepository.pointComplete(RidePointCompleteRequest(
        cardPayed: event.cardPayed,
        cashPayed: event.cashPayed,
        payMethod: event.payMethod,
        terminalCode: event.terminalCode,
        pointId: _pointId,
      ));

      emit(state.copyWith(status: OrderLinesStatus.completingPointSucceeded));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: OrderLinesStatus.completingPointFailure));
      addError(error, stackTrace);
    }
  }
}
