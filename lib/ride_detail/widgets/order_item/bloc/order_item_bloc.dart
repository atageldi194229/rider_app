import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';

part 'order_item_event.dart';
part 'order_item_state.dart';

class OrderItemBloc extends Bloc<OrderItemEvent, OrderItemState> {
  OrderItemBloc({
    required Order order,
  })  : _order = order,
        super(const OrderItemInitial()) {
    on<OrderItemBarcodeRead>(_onOrderItemBarcodeRead);
  }

  final Order _order;

  FutureOr<void> _onOrderItemBarcodeRead(OrderItemBarcodeRead event, Emitter<OrderItemState> emit) {
    emit(const OrderItemBarcodeScanStarted());

    final barcode = event.barcode.trim();
    final correct = _order.orderId.toString().trim();

    final isBarcodeScanningCanceled = barcode == '-1';

    // if canceled do nothing
    if (isBarcodeScanningCanceled) return Future.value();

    if (barcode != "null" && barcode == correct) {
      emit(OrderItemBarcodeScanSuccess(barcode));
    } else {
      emit(OrderItemBarcodeScanFailure(barcode));
    }
  }
}
