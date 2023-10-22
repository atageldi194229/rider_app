import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';

class OrderItemCardBody extends StatelessWidget {
  const OrderItemCardBody({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(UISpacing.md).copyWith(bottom: 0),
      child: Row(
        children: [
          /// Order address & order state
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Order address
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on, size: 15),
                    Expanded(
                      child: Text(
                        order.address?.address ?? '',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: UISpacing.xs),

                /// Order state
                UIBadge(
                  labelText: "${order.orderStateTranslated}",
                  backgroundColor: order.orderStateColor?.toColor(),
                  color: Colors.white,
                ),
              ],
            ),
          ),

          // const SizedBox(width: UISpacing.xs),

          /// Deadline time
          Text("${order.deadline}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
