// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars

import 'package:data_provider/data_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'line_string.g.dart';

/// [LineString] is a model for map
/// that stores multiple coordinates
/// that make one road example
@JsonSerializable(explicitToJson: true)
class LineString {
  /// Type: `LineString`
  final String? type;

  /// Coordinates
  @JsonKey(fromJson: coordinatesfromJson)
  final List<Coordinates>? coordinates;

  LineString({
    this.type,
    this.coordinates,
  });

  factory LineString.fromJson(Map<String, dynamic> json) => _$LineStringFromJson(json);
  Map<String, dynamic> toJson() => _$LineStringToJson(this);
}

List<Coordinates>? coordinatesfromJson(List<dynamic>? json) => json?.map((e) => (e as List).cast<double>()).map((e) => Coordinates(lat: e[0], lng: e[1])).toList();

// /// Coordinates ex: Coordinates(lat, lng)
// class Coordinates {
//   final double lat;
//   final double lng;

//   Coordinates({
//     required this.lat,
//     required this.lng,
//   });

//   factory Coordinates.fromJson(List<double> json) => Coordinates(lat: json[0], lng: json[1]);
//   List<double> toJson() => [lat, lng];
// }
