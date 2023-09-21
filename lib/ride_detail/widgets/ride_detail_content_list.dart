import 'package:asman_rider/ride_detail/ride_detail.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';

class RideDetailContentList extends StatelessWidget {
  const RideDetailContentList({required this.orders, super.key});

  final List<Order> orders;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(UISpacing.lg),
      sliver: SliverList.separated(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return OrderItemCard(
            order: orders[index],
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: UISpacing.lg),
      ),
    );
  }
}
