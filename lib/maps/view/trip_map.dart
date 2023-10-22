import 'package:asman_rider/maps/maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as l2;
import 'package:rider_ui/rider_ui.dart';

class TripMap extends StatefulWidget {
  /// Route constructor to display the widget inside a [Scaffold].
  static Route<void> route({
    l2.LatLng? center,
    List<List<l2.LatLng>>? polylines,
    List<Marker>? markers,
  }) {
    return PageRouteBuilder<void>(
      pageBuilder: (_, __, ___) => Scaffold(
        appBar: AppBar(
          title: const Text("Map"),
        ),
        body: TripMap(
          center: center,
          polylines: polylines,
          markers: markers,
        ),
      ),
    );
  }

  const TripMap({
    l2.LatLng? center,
    List<List<l2.LatLng>>? polylines,
    List<Marker>? markers,
    super.key,
  })  : _center = center ?? kAshgabatCoordinates,
        _polylines = polylines,
        _markers = markers ?? const [];

  final l2.LatLng? _center;
  final List<List<l2.LatLng>>? _polylines;
  final List<Marker> _markers;

  @override
  State<TripMap> createState() => _TripMapState();
}

class _TripMapState extends State<TripMap> {
  final _mapController = MapController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final markerList = widget._markers;

      if (markerList.isNotEmpty) {
        // Create an empty LatLngBounds object
        LatLngBounds bounds = LatLngBounds(markerList.first.point, markerList.last.point);

        // Loop through the marker list and update the bounds
        for (Marker marker in markerList) {
          // Extend the bounds to include the marker position
          bounds.extend(marker.point);
        }

        // Fit the map to the bounds with some padding
        final boundCenter = _mapController.centerZoomFitBounds(
          bounds,
          options: const FitBoundsOptions(
            padding: EdgeInsets.all(UISpacing.xlg),
          ),
        );

        _mapController.move(boundCenter.center, boundCenter.zoom);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        center: widget._center,
        zoom: 15,
      ),
      children: [
        kTileLayer,
        if (widget._polylines != null)
          PolylineLayer(
            polylines: widget._polylines!
                .map<Polyline>(
                  (points) => Polyline(
                    color: const Color.fromARGB(255, 14, 51, 106),
                    borderColor: Colors.grey.shade400,
                    borderStrokeWidth: 4,
                    strokeWidth: 3,
                    points: points,
                  ),
                )
                .toList(),
          ),
        if (widget._markers.isNotEmpty)
          MarkerLayer(
            rotate: true,
            markers: widget._markers,
          ),
      ],
    );
  }
}
