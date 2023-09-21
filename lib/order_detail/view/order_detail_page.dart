import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/order_detail/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_repository/order_repository.dart';
import 'package:ride_repository/ride_repository.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({
    super.key,
    required this.orderId,
    this.isActionsEnabled,
  });

  final int orderId;
  final bool? isActionsEnabled;

  static Route<bool?> route({required int orderId, bool? isActionsEnabled}) {
    return MaterialPageRoute<bool?>(
      builder: (_) => OrderDetailPage(
        orderId: orderId,
        isActionsEnabled: isActionsEnabled,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderDetailBloc(
        orderId: orderId,
        orderRepository: context.read<OrderRepository>(),
        rideRepository: context.read<RideRepository>(),
      )..add(OrderDetailRequested()),
      child: OrderDetailPageParameters(
        isActionsEnabled: isActionsEnabled,
        child: const OrderDetailView(),
      ),
    );
  }
}

class OrderDetailView extends StatelessWidget {
  const OrderDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.orderDetail),
      ),
      body: const OrderDetailContent(),
    );
  }
}

class OrderDetailPageParameters extends InheritedWidget {
  const OrderDetailPageParameters({
    super.key,
    required super.child,
    bool? isActionsEnabled,
  }) : isActionsEnabled = isActionsEnabled ?? false;

  final bool isActionsEnabled;

  static OrderDetailPageParameters of(BuildContext context) {
    final OrderDetailPageParameters? result = context.dependOnInheritedWidgetOfExactType<OrderDetailPageParameters>();
    assert(result != null, 'No OrderDetailPageParameters found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
