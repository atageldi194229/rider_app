import 'package:asman_rider/active_ride/active_ride.dart';
import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/maps/maps.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rider_ui/rider_ui.dart';

class RideDetailExtraButtons extends StatelessWidget {
  const RideDetailExtraButtons({super.key, required this.rideDetail});

  final RideDetail rideDetail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(UISpacing.lg).copyWith(bottom: 0),
        child: UICard(
          // borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.all(UISpacing.xs),
            child: Row(
              children: [
                UIIconButton(
                  onTap: () {
                    /// initialize usable variables
                    List<Marker> markers = [];
                    LatLng? center;
                    final warehousePoint = rideDetail.warehousePoint;
                    final polyline = rideDetail.path?.coordinates?.map((e) => LatLng(e.lat, e.lng)).toList() ?? [];

                    /// calculate center
                    if (warehousePoint != null) {
                      final point = LatLng(warehousePoint.lat, warehousePoint.lng);

                      markers.add(Marker(
                        point: point,
                        anchorPos: AnchorPos.align(AnchorAlign.top),
                        builder: (context) => theme.icons.sklad(),
                      ));

                      center = point;
                    }

                    /// create markers list
                    for (int i = 0; i < (rideDetail.orders?.length ?? 0); i++) {
                      final order = rideDetail.orders![i];
                      markers.add(_buildMarker(context, order, "${i + 1}"));
                    }

                    /// Finall navigate to map page
                    Navigator.of(context).push(TripMap.route(
                      center: center,
                      markers: markers,
                      polylines: [polyline],
                    ));
                  },
                  tooltip: "Map",
                  padding: const EdgeInsets.all(UISpacing.sm),

                  // style: IconButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0))),

                  child: const Icon(Icons.map_rounded, color: Colors.white),
                ),
                const SizedBox(width: UISpacing.xs),
                BlocBuilder<ActiveRideBloc, ActiveRideState>(
                  builder: (context, state) {
                    if (state.rideId == null || state.rideId != rideDetail.id) {
                      return const SizedBox();
                    }

                    if (state.status == ActiveRideStatus.loading) {
                      return const UILoader(
                        size: 24.0,
                        padding: EdgeInsets.all(UISpacing.md),
                      );
                    }

                    return UIIconButton(
                      padding: EdgeInsets.zero,
                      onTap: () => context.read<ActiveRideBloc>().add(ActiveRideTransferPressed()),
                      tooltip: "Transfer",
                      child: const Icon(Icons.arrow_outward_rounded, color: Colors.white),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildMarker(BuildContext context, Order order, String markerText) {
    final coords = order.address!.coordinates!;
    final point = LatLng(coords.lat, coords.lng);

    return Marker(
      point: point,
      builder: (context) => CustomPopupMenu(
        arrowColor: Colors.blue,
        arrowSize: 25,
        pressType: PressType.singleClick,
        child: CircleAvatar(
          backgroundColor: Colors.red,
          child: Text(
            markerText,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        menuBuilder: () {
          return Container(
            width: MediaQuery.of(context).size.width * 0.5,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '#${order.orderId}',
                      style: TextStyle(
                        color: Colors.blue.shade900,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  order.customerName!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text('${order.address?.address}'),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: context.l10n.addressBuilding),
                      TextSpan(text: ' ${order.address?.building ?? "-"} '),
                      TextSpan(text: context.l10n.addressFloor),
                      TextSpan(text: ' ${order.address?.floor ?? "-"} '),
                      TextSpan(text: context.l10n.addressFloor),
                      TextSpan(text: ' ${order.address?.door ?? "-"}'),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "+${order.customerPhone!}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
