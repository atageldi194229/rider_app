import 'package:asman_rider/ride_detail/ride_detail.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';

class RideDetailContentList extends StatelessWidget {
  const RideDetailContentList({required this.rideDetail, super.key});

  final RideDetail rideDetail;

  @override
  Widget build(BuildContext context) {
    final orders = rideDetail.orders ?? [];

    return SliverPadding(
      padding: const EdgeInsets.all(UISpacing.lg),
      sliver: SliverList.separated(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return OrderItemCard(
            order: orders[index],
            rideId: rideDetail.id!,
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: UISpacing.lg),
      ),
    );
  }
}
