import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:asman_rider/l10n/l10n.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:rider_ui/rider_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderItemCardActions extends StatelessWidget {
  const OrderItemCardActions({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(UISpacing.md),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xfff7b84b),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(UISpacing.xs),
                ),
              ),
              onPressed: () async {
                Uri url = Uri.parse('tel://+//${order.customerPhone}');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.call_outlined, size: 14, color: Colors.white),
                  Text(context.l10n.call, style: const TextStyle(fontSize: 13, color: Colors.white)),
                ],
              ),
            ),
          ),
          const SizedBox(width: UISpacing.md),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.secondaryContainer, // const Color(0xff58caea),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(UISpacing.xs),
                ),
              ),
              onPressed: _openNavigator,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on_outlined, size: 14, color: Colors.white),
                  Text(context.l10n.navigate, style: const TextStyle(fontSize: 13, color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openNavigator() async {
    final coordinates = order.address?.coordinates;

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
  }
}
