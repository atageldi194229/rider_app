// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_lines_bloc.dart';

enum OrderLinesStatus {
  initial,

  loading,
  populated, // success
  failure,

  completingPoint,
  completingPointFailure,
  completingPointSucceeded,

  updatingItemQuantity,
  updatingItemQuantityFailure,
  updatingItemQuantitySucceeded,
}

final class OrderLinesState extends Equatable {
  const OrderLinesState({
    required this.status,
    this.orderLines,
    this.updatingLineId,
  });

  const OrderLinesState.initial() : this(status: OrderLinesStatus.initial);

  final OrderLinesStatus status;
  final OrderLines? orderLines;
  final int? updatingLineId;

  @override
  List<Object?> get props => [status, orderLines, updatingLineId];

  OrderLinesState copyWith({
    OrderLinesStatus? status,
    OrderLines? orderLines,
    int? updatingLineId,
  }) {
    return OrderLinesState(
      status: status ?? this.status,
      orderLines: orderLines ?? this.orderLines,
      updatingLineId: updatingLineId ?? this.updatingLineId,
    );
  }
}
