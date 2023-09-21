import 'package:asman_rider/env/env.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

const kMapBaseUrl = Env.mapUrl;
const kAshgabatCoordinates = LatLng(37.86, 58.14);

final kTileLayer = TileLayer(
  urlTemplate: "$kMapBaseUrl/tile/{z}/{x}/{y}.png",
);
