import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/order_lines/order_lines.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailDescription extends StatelessWidget {
  const OrderDetailDescription({
    required this.orderDetail,
    super.key,
  });

  final OrderDetail orderDetail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final keyTextStyle = theme.textTheme.labelLarge?.copyWith(color: Colors.grey);

    List<Widget> entries = [
      ListTile(
        title: Text("${orderDetail.deadline}"),
        trailing: Text("${orderDetail.orderState}"),
      ),
      ListTile(
        title: Text(context.l10n.orderId, style: keyTextStyle),
        subtitle: Text("#${orderDetail.id}"),
      ),
      ListTile(
        title: Text(context.l10n.customerName, style: keyTextStyle),
        subtitle: Text("${orderDetail.customerName}"),
      ),
      ListTile(
        title: Text(context.l10n.address, style: keyTextStyle),
        subtitle: Text([
          "${context.l10n.addressTitle}: ${orderDetail.address?.title ?? ''}",
          "${context.l10n.address}: ${orderDetail.address?.address ?? ''}",
          "${context.l10n.addressBuilding}: ${orderDetail.address?.building ?? ''}",
          "${context.l10n.addressFloor}: ${orderDetail.address?.floor ?? ''}",
          "${context.l10n.addressDoor}: ${orderDetail.address?.door ?? ''}",
        ].join("\n")),
      ),
      ListTile(
        title: Text(context.l10n.customerPhone, style: keyTextStyle),
        subtitle: Text("${orderDetail.customerPhone}"),
        trailing: IconButton(
          onPressed: () async {
            Uri url = Uri.parse('tel://+${orderDetail.customerPhone}');
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            }
          },
          icon: const Icon(Icons.call_rounded),
        ),
      ),
      ListTile(
        title: Text(context.l10n.payMethod, style: keyTextStyle),
        subtitle: Text(orderDetail.payMethod ?? ''),
      ),
      ListTile(
        onTap: () {
          Navigator.of(context).push(OrderLinesPage.route(
            orderId: orderDetail.id!,
            pointId: orderDetail.pointId!,
          ));
        },
        title: Row(
          children: [
            Expanded(
              child: Text(
                context.l10n.goodsToBeDelivered,
                style: keyTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: UISpacing.sm),
            Badge(label: Text("${orderDetail.linesCount}")),
          ],
        ),
        trailing: const Icon(Icons.navigate_next_rounded),
      ),
      ListTile(
        title: Text(context.l10n.totalWeight, style: keyTextStyle),
        subtitle: Text("${orderDetail.totalWeight} gr"),
      ),
      ListTile(
        title: Text(context.l10n.zoneId, style: keyTextStyle),
        subtitle: Text(orderDetail.zoneName ?? ''),
      ),
      ListTile(
        title: Text(context.l10n.notes, style: keyTextStyle),
        subtitle: Text(orderDetail.notes ?? ''),
      ),
    ];

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(UISpacing.md),
        child: UICard(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(UISpacing.lg),
            itemCount: entries.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return entries[index];
            },
          ),
        ),
      ),
    );
  }
}
