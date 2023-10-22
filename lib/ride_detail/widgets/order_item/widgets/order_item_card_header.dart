import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';

class OrderItemCardHeader extends StatelessWidget {
  const OrderItemCardHeader({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(UISpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ID & STATUS
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Order ID,
              Text(
                "${order.reference}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xff5ea3cb),
                ),
              ),

              const SizedBox(height: UISpacing.xs),

              /// Order point status
              if (order.pointStatusTranslation != null)
                UIBadge(
                  labelText: "${order.pointStatusTranslation}",
                  backgroundColor: order.pointStatusColor?.toColor(),
                  color: Colors.white,
                ),
            ],
          ),

          const Spacer(),

          /// Order total amount text
          Row(
            children: [
              /// order Total pay text
              if (order.totalText != null) ...[
                const Icon(Icons.money_sharp, size: 15, color: Colors.grey),
                Text(
                  "${order.totalText}",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],

              /// Order line number text
              if (order.itemsCount != null) ...[
                const SizedBox(width: UISpacing.sm),
                const Icon(Icons.shopping_cart_sharp, size: 15, color: Colors.grey),
                Text("${order.itemsCount}", style: const TextStyle(fontSize: 14, color: Colors.grey)),
              ],

              /// Order slot number text
              if (order.slotNumber != null) ...[
                const SizedBox(width: UISpacing.sm),
                const Icon(Icons.folder_open_sharp, size: 15, color: Colors.grey),
                Text("${order.slotNumber}", style: const TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
