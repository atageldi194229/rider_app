part of 'ride_detail_bloc.dart';

@immutable
abstract class RideDetailEvent extends Equatable {
  const RideDetailEvent();

  @override
  List<Object> get props => [];
}

@immutable
class RideDetailRequested extends RideDetailEvent {}

@immutable
class RideDetailOrderBarcodeRead extends RideDetailEvent {
  final String barcode;

  const RideDetailOrderBarcodeRead(this.barcode);

  @override
  List<Object> get props => [barcode];
}

@immutable
class RideDetailStartRequested extends RideDetailEvent {}
