part of 'order_lines_bloc.dart';

sealed class OrderLinesEvent extends Equatable {
  const OrderLinesEvent();

  @override
  List<Object> get props => [];
}

final class OrderLinesRequested extends OrderLinesEvent {}

final class OrderLinesItemIncremented extends OrderLinesEvent {
  final int lineId;

  const OrderLinesItemIncremented(this.lineId);

  @override
  List<Object> get props => [lineId];
}

final class OrderLinesItemDecremented extends OrderLinesEvent {
  final int lineId;

  const OrderLinesItemDecremented(this.lineId);

  @override
  List<Object> get props => [lineId];
}

final class OrderLinesPointComplete extends OrderLinesEvent {
  final String payMethod;
  final double cardPayed;
  final double cashPayed;
  final String terminalCode;

  const OrderLinesPointComplete({
    required this.payMethod,
    required this.cardPayed,
    required this.cashPayed,
    required this.terminalCode,
  });

  @override
  List<Object> get props => [payMethod, cardPayed, cashPayed, terminalCode];
}
