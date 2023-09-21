part of 'order_item_bloc.dart';

sealed class OrderItemEvent extends Equatable {
  const OrderItemEvent();

  @override
  List<Object> get props => [];
}

final class OrderItemBarcodeRead extends OrderItemEvent {
  final String barcode;

  const OrderItemBarcodeRead(this.barcode);

  @override
  List<Object> get props => [barcode];
}
