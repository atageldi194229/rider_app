import 'package:asman_rider/active_ride/active_ride.dart';
import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/order_detail/order_detail.dart';
import 'package:asman_rider/ride_detail/ride_detail.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider_ui/rider_ui.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({
    required this.rideId,
    required this.order,
    super.key,
  });

  final Order order;
  final int rideId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderItemBloc(order: order),
      child: BlocBuilder<ActiveRideBloc, ActiveRideState>(
        builder: (context, state) {
          final hasActiveRide = state.rideId != null;
          return OrderItemCardBarcodeScannerWidget(
            enabled: !hasActiveRide,
            order: order,
            dismissibleKey: Key(order.orderId.toString()),
            child: OrderItemCardView(order: order, rideId: rideId),
          );
        },
      ),
    );
  }
}

class OrderItemCardBarcodeScannerWidget extends StatelessWidget {
  const OrderItemCardBarcodeScannerWidget({
    required this.order,
    required this.dismissibleKey,
    required this.child,
    this.enabled = true,
  }) : super(key: dismissibleKey);

  final Order order;
  final Key dismissibleKey;
  final Widget child;
  final bool enabled;

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
    if (!enabled) return child;

    return Dismissible(
      key: dismissibleKey,
      confirmDismiss: (direction) async {
        scanBarcode(context);
        return false;
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<OrderItemBloc, OrderItemState>(
            listenWhen: (previous, current) => current is OrderItemBarcodeScanFailure,
            listener: (context, state) async {
              UtilDialog.showTryAgainDialog(
                context,
                title: "QR code nadogry",
                content: "Okadylan QR code: '${state.scannedBarcode} '"
                    "\nBolmaly  QR code: '${order.orderId}'",
                tryAgainText: context.l10n.tryAgain,
                cancelText: context.l10n.cancel,
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
        child: child,
      ),
    );
  }
}

class OrderItemCardView extends StatelessWidget {
  const OrderItemCardView({
    super.key,
    required this.order,
    required this.rideId,
  });

  final Order order;
  final int rideId;

  @override
  Widget build(BuildContext context) {
    final isOrderScanned = context.select((OrderItemBloc bloc) => bloc.state is OrderItemBarcodeScanSuccess);
    final isCurrentRideActive = context.select((ActiveRideBloc bloc) => bloc.state.rideId == rideId);

    return UICard(
      disabled: isCurrentRideActive ? order.disabled : null,
      border: !isOrderScanned ? null : Border.all(color: Colors.green, width: 2),
      child: InkWell(
        onTap: () {
          final currentRideId = context.read<RideDetailBloc>().state.rideDetail?.id;
          final activeRideId = context.read<ActiveRideBloc>().state.rideId;

          final isCurrentRideActive = activeRideId != null && activeRideId == currentRideId;

          Navigator.of(context)
              .push(
            OrderDetailPage.route(
              orderId: order.orderId!,
              isActionsEnabled: isCurrentRideActive,
            ),
          )
              .then((success) {
            if (success == true) {
              context.read<RideDetailBloc>().add(RideDetailRequested());
            }
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// First Row that shows id, point status, order price, line count and slot number.
            OrderItemCardHeader(order: order),

            const Divider(height: 1),

            /// Second row shows Order address
            OrderItemCardBody(order: order),

            // const Divider(height: 1),

            /// Order labels
            if (order.labels?.isNotEmpty == true) ...[
              _RowOfOrderLabels(labels: order.labels!),
              const Divider(height: 1),
            ],

            /// Order Item action buttons
            // OrderItemCardActions(order: order),
          ],
        ),
      ),
    );
  }
}

class _RowOfOrderLabels extends StatelessWidget {
  const _RowOfOrderLabels({
    required this.labels,
  });

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(UISpacing.md),
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: UISpacing.md,
        children: labels
            .map<Widget>(
              (label) => UIChip(
                label: Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
