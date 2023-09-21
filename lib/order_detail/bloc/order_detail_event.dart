part of 'order_detail_bloc.dart';

@immutable
sealed class OrderDetailEvent extends Equatable {
  const OrderDetailEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class OrderDetailRequested extends OrderDetailEvent {}

@immutable
final class OrderDetailArrivedPressed extends OrderDetailEvent {}

@immutable
final class OrderDetailDeliverPressed extends OrderDetailEvent {}
