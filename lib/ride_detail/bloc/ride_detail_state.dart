// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ride_detail_bloc.dart';

enum RideDetailStatus {
  initial,

  loading,
  populated,
  failure,
}

@immutable
class RideDetailState extends Equatable {
  final RideDetailStatus status;
  final RideDetail? rideDetail;
  final Set<String> readBarcodeList;

  const RideDetailState({
    required this.status,
    this.rideDetail,
    this.readBarcodeList = const {},
  });

  const RideDetailState.initial() : this(status: RideDetailStatus.initial);

  /// To check if all orders are read by barcode reader
  bool get isAllOrdersRead {
    final orderIds = rideDetail?.orders?.map<int>((e) => e.orderId!);
    if (orderIds == null) return false;
    return orderIds.every((orderId) => readBarcodeList.contains(orderId.toString()));
  }

  @override
  List<Object?> get props => [status, rideDetail, readBarcodeList];

  RideDetailState copyWith({
    RideDetailStatus? status,
    RideDetail? rideDetail,
    Set<String>? readBarcodeList,
    String? readBarcodeError,
  }) {
    return RideDetailState(
      status: status ?? this.status,
      rideDetail: rideDetail ?? this.rideDetail,
      readBarcodeList: readBarcodeList ?? this.readBarcodeList,
    );
  }
}
