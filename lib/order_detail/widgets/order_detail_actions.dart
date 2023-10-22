import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/order_detail/order_detail.dart';
import 'package:asman_rider/order_lines/order_lines.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider_ui/rider_ui.dart';

class OrderDetailActions extends StatelessWidget {
  const OrderDetailActions({
    required this.orderDetail,
    super.key,
  });

  final OrderDetail orderDetail;

  @override
  Widget build(BuildContext context) {
    final isActionsEnabled = OrderDetailPageParameters.of(context).isActionsEnabled;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(UISpacing.lg).copyWith(top: 0),
        child: Column(
          children: [
            if (isActionsEnabled) ...[
              // If the order's point status is PENDING, then show ARRIVED button
              if (orderDetail.pointStatus == PointStatus.pending) ...[
                UIActionButton(
                  action: () async {
                    final bloc = context.read<OrderDetailBloc>();
                    bloc.add(OrderDetailArrivedPressed());

                    /// Wait until any result
                    OrderDetailState state;
                    do {
                      state = await bloc.stream.first;
                    } while (state.status == OrderDetailStatus.settingPointStatusArrived);
                  },
                  text: context.l10n.arrived.toUpperCase(),
                ),
              ],

              // If the order's point status is ARRIVED, then show DELIVER button
              if (orderDetail.pointStatus == PointStatus.arrived) ...[
                UIActionButton(
                  action: () {
                    Navigator.of(context)
                        .push(OrderLinesPage.route(
                      orderId: orderDetail.id!,
                      pointId: orderDetail.pointId!,
                      mode: OrderLinesMode.editable,
                    ))
                        .then((success) {
                      if (success == true) {
                        // context.read<OrderDetailBloc>().add(OrderDetailRequested());
                        Navigator.of(context).pop(true);
                      }
                    });
                  },
                  text: context.l10n.deliver.toUpperCase(),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
