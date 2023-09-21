// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_detail_bloc.dart';

enum OrderDetailStatus {
  initial,

  loading,
  populated,
  failure,

  settingPointStatusArrived,
  settingPointStatusArrivedFailure,
  settingPointStatusArrivedSucceeded,
}

@immutable
class OrderDetailState extends Equatable {
  final OrderDetailStatus status;
  final OrderDetail? orderDetail;

  const OrderDetailState({
    required this.status,
    this.orderDetail,
  });

  const OrderDetailState.initial() : this(status: OrderDetailStatus.initial);

  @override
  List<Object?> get props => [status, orderDetail];

  OrderDetailState copyWith({
    OrderDetailStatus? status,
    OrderDetail? orderDetail,
  }) {
    return OrderDetailState(
      status: status ?? this.status,
      orderDetail: orderDetail ?? this.orderDetail,
    );
  }
}
