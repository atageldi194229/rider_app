import 'package:asman_rider/active_ride/active_ride.dart';
import 'package:asman_rider/order_detail/order_detail.dart';
import 'package:asman_rider/ride_detail/ride_detail.dart';
import 'package:data_provider/data_provider.dart';
import 'package:float_column/float_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider_ui/rider_ui.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({required this.order, super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderItemBloc(order: order),
      child: UICard(
        child: InkWell(
          onTap: () {
            final currentRideId = context.read<RideDetailBloc>().state.rideDetail?.id;
            final activeRideId = context.read<ActiveRideBloc>().state.rideId;

            final isCurrentRideActive = activeRideId != null && activeRideId == currentRideId;

            Navigator.of(context)
                .push(OrderDetailPage.route(
              orderId: order.orderId!,
              isActionsEnabled: isCurrentRideActive,
            ))
                .then((success) {
              if (success == true) {
                context.read<RideDetailBloc>().add(RideDetailRequested());
              }
            });
          },
          child: Column(
            children: [
              _buildContent(context),
              OrderItemCardActions(order: order),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(UISpacing.lg).copyWith(bottom: UISpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("#${order.orderId}", style: theme.textTheme.titleLarge),
                  const SizedBox(height: UISpacing.md),
                  Text("${order.customerName}", style: theme.textTheme.bodyLarge),
                ],
              ),
              const Spacer(),
              Chip(
                // padding: EdgeInsets.zero,
                label: Text(
                  "${order.pointStatusTranslation?.toUpperCase()}",
                  overflow: TextOverflow.clip,
                  style: theme.textTheme.labelSmall?.copyWith(fontSize: 9.0, fontWeight: FontWeight.bold),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ],
          ),
          const SizedBox(height: UISpacing.md),
          FloatColumn(
            children: [
              WrappableText(
                text: TextSpan(
                  children: [
                    const WidgetSpan(
                      child: Icon(Icons.location_on, size: 16),
                    ),
                    TextSpan(text: " ${order.address?.address} "),
                  ],
                ),
              ),
              Floatable(
                float: FCFloat.end,
                child: Text(
                  "${order.placedAt}",
                  style: theme.textTheme.bodyLarge?.copyWith(fontSize: 35),
                ),
              ),
            ],
          ),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: UISpacing.md,
            children: order.labels
                    ?.map<Widget>(
                      (label) => Chip(
                        label: Text(label, style: theme.textTheme.labelMedium),
                      ),
                    )
                    .toList() ??
                [],
          ),
        ],
      ),
    );
  }
}
