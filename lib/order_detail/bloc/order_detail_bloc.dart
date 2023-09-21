import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show immutable;
import 'package:order_repository/order_repository.dart';
import 'package:ride_repository/ride_repository.dart';

part 'order_detail_event.dart';
part 'order_detail_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  OrderDetailBloc({
    required OrderRepository orderRepository,
    required RideRepository rideRepository,
    required int orderId,
  })  : _orderRepository = orderRepository,
        _rideRepository = rideRepository,
        _orderId = orderId,
        super(const OrderDetailState.initial()) {
    on<OrderDetailRequested>(_onOrderDetailRequested);
    on<OrderDetailArrivedPressed>(_onOrderDetailArrivedPressed);
  }

  final OrderRepository _orderRepository;
  final RideRepository _rideRepository;
  final int _orderId;

  FutureOr<void> _onOrderDetailRequested(OrderDetailRequested event, Emitter<OrderDetailState> emit) async {
    try {
      emit(state.copyWith(status: OrderDetailStatus.loading));

      final orderDetail = await _orderRepository.getDetail(_orderId);

      emit(state.copyWith(
        status: OrderDetailStatus.populated,
        orderDetail: orderDetail,
      ));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: OrderDetailStatus.failure));
      addError(error, stackTrace);
    }
  }

  FutureOr<void> _onOrderDetailArrivedPressed(OrderDetailArrivedPressed event, Emitter<OrderDetailState> emit) async {
    try {
      emit(state.copyWith(status: OrderDetailStatus.settingPointStatusArrived));

      final pointId = state.orderDetail?.pointId;

      if (pointId != null) {
        await _rideRepository.pointArrive(pointId);
        emit(state.copyWith(status: OrderDetailStatus.settingPointStatusArrivedSucceeded));
        add(OrderDetailRequested());
      }
    } catch (error, stackTrace) {
      emit(state.copyWith(status: OrderDetailStatus.settingPointStatusArrivedFailure));
      addError(error, stackTrace);
    }
  }
}
