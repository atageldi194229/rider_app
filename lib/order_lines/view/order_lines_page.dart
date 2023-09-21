import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/order_lines/order_lines.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_repository/order_repository.dart';
import 'package:ride_repository/ride_repository.dart';

class OrderLinesPage extends StatelessWidget {
  const OrderLinesPage({required this.orderId, required this.pointId, this.mode, super.key});

  final int orderId;
  final int pointId;
  final OrderLinesMode? mode;

  static Route<bool?> route({required int orderId, required int pointId, OrderLinesMode? mode}) {
    return MaterialPageRoute<bool?>(
      builder: (_) => OrderLinesPage(
        orderId: orderId,
        pointId: pointId,
        mode: mode,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderLinesBloc(
        orderId: orderId,
        pointId: pointId,
        orderRepository: context.read<OrderRepository>(),
        rideRepository: context.read<RideRepository>(),
        mode: mode,
      )..add(OrderLinesRequested()),
      child: const OrderLinesView(),
    );
  }
}

class OrderLinesView extends StatelessWidget {
  const OrderLinesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderLinesBloc, OrderLinesState>(
      listenWhen: (previous, current) => current.status == OrderLinesStatus.completingPointSucceeded,
      listener: (context, state) {
        if (state.status == OrderLinesStatus.completingPointSucceeded) {
          Navigator.of(context).pop(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.orderProducts),
        ),
        body: const OrderLinesContent(),
      ),
    );
  }
}
