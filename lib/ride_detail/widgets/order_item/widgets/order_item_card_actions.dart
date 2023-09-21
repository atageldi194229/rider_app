import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:asman_rider/ride_detail/ride_detail.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider_ui/rider_ui.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderItemCardActions extends StatelessWidget {
  const OrderItemCardActions({super.key, required this.order});

  final Order order;

  void scanBarcode(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SimpleBarcodeScannerPage(),
      ),
    ).then((res) {
      context.read<OrderItemBloc>().add(OrderItemBarcodeRead(res.toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<OrderItemBloc, OrderItemState>(
          listenWhen: (previous, current) => current is OrderItemBarcodeScanFailure,
          listener: (context, state) async {
            UtilDialog.showTryAgainDialog(
              context,
              title: "QR code nadogry",
              content: "Okadylan QR code: '${state.scannedBarcode} '"
                  "\nBolmaly  QR code: '${order.orderId}'",
            ).then((tryAgain) {
              if (tryAgain == true) {
                scanBarcode(context);
              }
            });
          },
        ),
        BlocListener<OrderItemBloc, OrderItemState>(
          listenWhen: (previous, current) => current is OrderItemBarcodeScanSuccess,
          listener: (context, state) {
            context.read<RideDetailBloc>().add(RideDetailOrderBarcodeRead(state.scannedBarcode));
          },
        ),
      ],
      child: Column(
        children: [
          const Divider(height: 1),
          IntrinsicHeight(
            child: Row(
              children: [
                IconButton(
                  onPressed: () async {
                    Uri url = Uri.parse('tel://+//${order.customerPhone}');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  icon: const Icon(Icons.call_rounded),
                ),
                const VerticalDivider(width: 1),
                IconButton(
                  onPressed: () => scanBarcode(context),
                  icon: BlocBuilder<OrderItemBloc, OrderItemState>(
                    buildWhen: (previous, current) => current is OrderItemBarcodeScanSuccess,
                    builder: (context, state) {
                      final isOrderScanned = state is OrderItemBarcodeScanSuccess;

                      return Icon(
                        Icons.qr_code_scanner_rounded,
                        color: isOrderScanned ? Colors.green : null,
                      );
                    },
                  ),
                ),
                const VerticalDivider(width: 1),
                IconButton(
                  onPressed: _openNavigator,
                  icon: const Icon(Icons.location_on_rounded),
                ),
                const VerticalDivider(width: 1),
                IconButton(
                  onPressed: () {
                    if (order.hasNotes == true) {
                      UtilDialog.showTextDialog(
                        context,
                        title: "Note",
                        content: order.hasNotes.toString(),
                      );
                    }
                  },
                  icon: order.hasNotes == false
                      ? const Icon(Icons.sticky_note_2_rounded)
                      : const Badge(
                          child: Icon(Icons.sticky_note_2_rounded),
                        ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: Center(
                    child: Text(
                      "${order.orderState}",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openNavigator() {
    final coordinates = order.address?.coordinates;

    if (Platform.isAndroid && coordinates != null) {
      var destination = "${coordinates.lat},${coordinates.lng}";
      AndroidIntent intent = AndroidIntent(
        action: "action_view",
        data: 'https://www.google.com/maps/dir/?api=1&destination=$destination&travelmode=driving',
      );
      intent.launch();
    }
  }
}
