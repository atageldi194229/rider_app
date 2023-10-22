import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';

class OrderDetailContentHeader extends StatelessWidget {
  const OrderDetailContentHeader({super.key, required this.orderDetail});

  final OrderDetail orderDetail;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: UICard(
        borderRadius: BorderRadius.zero,
        padding: const EdgeInsets.symmetric(horizontal: UISpacing.lg, vertical: UISpacing.md),
        child: Row(
          children: [
            Text(
              orderDetail.reference ?? '',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            if (orderDetail.pointStatusTranslated != null)
              UIBadge(
                labelText: orderDetail.pointStatusTranslated ?? '',
                backgroundColor: orderDetail.pointStatusColor?.toColor(),
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
