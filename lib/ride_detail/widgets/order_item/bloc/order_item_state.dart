part of 'order_item_bloc.dart';

sealed class OrderItemState extends Equatable {
  const OrderItemState(this.scannedBarcode);

  final String scannedBarcode;

  @override
  List<Object> get props => [scannedBarcode];
}

final class OrderItemInitial extends OrderItemState {
  const OrderItemInitial() : super('');
}

final class OrderItemBarcodeScanStarted extends OrderItemState {
  const OrderItemBarcodeScanStarted() : super('');
}

final class OrderItemBarcodeScanFailure extends OrderItemState {
  const OrderItemBarcodeScanFailure(super.scannedBarcode);
}

final class OrderItemBarcodeScanSuccess extends OrderItemState {
  const OrderItemBarcodeScanSuccess(super.scannedBarcode);
}
