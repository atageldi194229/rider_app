import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/order_lines/order_lines.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:rider_ui/rider_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailDescription extends StatelessWidget {
  OrderDetailDescription({
    required this.orderDetail,
    super.key,
  });

  final OrderDetail orderDetail;
  final ValueNotifier<bool> navigatorLoadNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    const textStyle = TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold);
    const keyTextStyle = TextStyle(fontSize: 14.0, color: Colors.grey);

    List<Widget> entries = [
      // Order info
      if (orderDetail.info != null) ...[
        UICard(
          padding: const EdgeInsets.all(UISpacing.md),
          child: Row(
            children: [
              Expanded(child: Text("${orderDetail.info}", style: textStyle)),
              const SizedBox(width: UISpacing.sm),
              const Icon(Icons.info),
            ],
          ),
        ),
      ],

      // Order notes
      if (orderDetail.notes != null) ...[
        UICard(
          padding: const EdgeInsets.all(UISpacing.md),
          child: Row(
            children: [
              Expanded(child: Text("${orderDetail.notes}", style: textStyle)),
              const SizedBox(width: UISpacing.sm),
              const Icon(Icons.info),
            ],
          ),
        ),
      ],

      // Customer name & phone number
      UICard(
        padding: const EdgeInsets.all(UISpacing.sm),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${orderDetail.customerName}", style: textStyle),
                const SizedBox(height: UISpacing.sm),
                Text("+${orderDetail.customerPhone}", style: textStyle),
              ],
            ),
            const Spacer(),
            _IconButton(
              onTap: () async {
                Uri url = Uri.parse('tel://+//${orderDetail.customerPhone}');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
              },
              child: const Icon(Icons.call_rounded),
            ),
          ],
        ),
      ),

      // Address & Navigator
      UICard(
        padding: const EdgeInsets.all(UISpacing.sm),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderDetail.address?.address ?? '',
                    style: textStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: UISpacing.xs),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${context.l10n.addressBuilding}:", style: keyTextStyle),
                      Expanded(child: Text(orderDetail.address?.building ?? '', style: textStyle)),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${context.l10n.addressFloor}:", style: keyTextStyle),
                      Expanded(child: Text(orderDetail.address?.floor ?? '', style: textStyle)),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${context.l10n.addressDoor}:", style: keyTextStyle),
                      Expanded(child: Text(orderDetail.address?.door ?? '', style: textStyle)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: UISpacing.sm),
            ValueListenableBuilder(
              valueListenable: navigatorLoadNotifier,
              builder: (context, value, child) {
                if (value) {
                  return const UILoader(size: 24);
                }

                return _IconButton(
                  onTap: _openNavigator,
                  child: const Icon(Icons.assistant_navigation),
                );
              },
            ),
          ],
        ),
      ),

      // Goods to be delivered
      UICard(
        padding: const EdgeInsets.all(UISpacing.sm),
        child: Row(
          children: [
            Expanded(
              child: Text(
                context.l10n.goodsToBeDelivered,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: UISpacing.sm),
            _IconButton(
              onTap: () {
                Navigator.of(context).push(OrderLinesPage.route(
                  orderId: orderDetail.id!,
                  pointId: orderDetail.pointId!,
                ));
              },
              child: Row(
                children: [
                  const Icon(Icons.arrow_forward_rounded),
                  Text(
                    "${orderDetail.linesCount}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Attributes of order
      if (orderDetail.attributes?.isNotEmpty == true)
        UIDataAttributes(
          attributes: orderDetail.attributes!.map((e) => (e.name, e.value)),
          nameTextStyle: keyTextStyle,
          valueTextStyle: textStyle,
        ),
    ];

    return SliverToBoxAdapter(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(UISpacing.lg),
        itemCount: entries.length,
        separatorBuilder: (context, index) => const SizedBox(height: UISpacing.lg),
        itemBuilder: (context, index) {
          return entries[index];
        },
      ),
    );
  }

  void _openNavigator() async {
    // start loading
    navigatorLoadNotifier.value = true;

    try {
      final coordinates = orderDetail.address?.coordinates;

      if (Platform.isAndroid && coordinates != null) {
        var destination = "${coordinates.lat},${coordinates.lng}";

        /// Google Map Navigator
        // AndroidIntent intent = AndroidIntent(
        //   action: "action_view",
        //   data: 'https://www.google.com/maps/dir/?api=1&destination=$destination&travelmode=driving',
        // );

        /// OM Map Navigator
        final location = await Location().getLocation();
        final currentLocation = "${location.latitude},${location.longitude}";
        AndroidIntent intent = AndroidIntent(
          action: 'action_view',
          // data: 'om://route?sll=${currentLocation.latitude},${currentLocation.longitude}&saddr=Start%20Point&dll=$latitude,$longitude&daddr=EndPoint&type=bicycle',
          data: 'om://route?sll=$currentLocation&saddr=Start%20Point&dll=$destination&daddr=EndPoint&type=bicycle',
        );

        intent.launch();
      }
    } catch (_) {}

    // stop loading
    navigatorLoadNotifier.value = false;
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(UISpacing.xs),
      color: Colors.grey.withOpacity(0.2),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(UISpacing.sm),
          child: child,
        ),
      ),
    );
  }
}
