import 'package:asman_rider/maps/maps.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:rider_ui/rider_ui.dart';

class RideDetailMap extends StatelessWidget {
  const RideDetailMap({required this.rideDetail, super.key});

  final RideDetail rideDetail;

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = [];
    LatLng? center;
    final warehousePoint = rideDetail.warehousePoint;
    final orderCoords = rideDetail.orders?.map<Coordinates?>((e) => e.address?.coordinates).cast<Coordinates>() ?? [];

    if (warehousePoint != null) {
      final point = LatLng(warehousePoint.lat, warehousePoint.lng);

      markers.add(Marker(
        point: point,
        builder: (context) => const Icon(
          Icons.location_city_rounded,
          color: Colors.blue,
        ),
      ));

      center = point;
    }

    for (final coords in orderCoords) {
      final point = LatLng(coords.lat, coords.lng);

      markers.add(Marker(
        point: point,
        builder: (context) => const Icon(
          Icons.location_pin,
          color: Colors.red,
        ),
      ));
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(UISpacing.lg).copyWith(bottom: 0),
        child: UICard(
          child: SizedBox(
            height: 0.345.sw,
            child: Stack(
              children: [
                IgnorePointer(
                  child: TripMap(
                    center: center,
                    markers: markers,
                  ),
                ),
                Positioned(
                  top: UISpacing.sm,
                  right: UISpacing.sm,
                  child: IconButton.filledTonal(
                    onPressed: () {
                      Navigator.of(context).push(TripMap.route(
                        center: center,
                        markers: markers,
                      ));
                    },
                    icon: const Icon(Icons.map_rounded),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
