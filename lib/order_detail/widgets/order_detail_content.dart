import 'package:asman_rider/network_error/network_error.dart';
import 'package:asman_rider/order_detail/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider_ui/rider_ui.dart';

class OrderDetailContent extends StatelessWidget {
  const OrderDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((OrderDetailBloc bloc) => bloc.state.status);
    final orderDetail = context.select((OrderDetailBloc bloc) => bloc.state.orderDetail);

    if (status == OrderDetailStatus.failure) {
      return NetworkError(
        onRetry: () => context.read<OrderDetailBloc>().add(OrderDetailRequested()),
      );
    }

    if (status == OrderDetailStatus.loading) {
      return const UILoader();
    }

    // status == OrderDetailStatus.populated
    if (orderDetail != null) {
      return CustomScrollView(
        slivers: [
          OrderDetailDescription(orderDetail: orderDetail),
          OrderDetailActions(orderDetail: orderDetail),
        ],
      );
    }

    return const SizedBox();
  }
}
