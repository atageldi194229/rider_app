// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:data_provider/data_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ride_detail.g.dart';

/// RideDetail model
@JsonSerializable(explicitToJson: true)
class RideDetail {
  /// ID
  final int? id;

  /// Distance text
  @JsonKey(name: 'distance_text')
  final String? distanceText;

  /// Durtation text
  @JsonKey(name: 'duration_text')
  final String? durationText;

  /// Status
  final RideStatus? status;

  /// Status translated
  @JsonKey(name: 'status_trans')
  final String? statusTranslated;

  /// Status color
  @JsonKey(name: 'status_color')
  final String? statusColor;

  /// Warehouse ID
  @JsonKey(name: 'warehouse_point')
  final Coordinates? warehousePoint;

  /// Orders
  final List<Order>? orders;

  /// Line String,
  /// another words coordinates
  final LineString? path;

  RideDetail({
    this.id,
    this.distanceText,
    this.durationText,
    this.status,
    this.statusTranslated,
    this.statusColor,
    this.warehousePoint,
    this.orders,
    this.path,
  });

  factory RideDetail.fromJson(Map<String, dynamic> json) => _$RideDetailFromJson(json);
  Map<String, dynamic> toJson() => _$RideDetailToJson(this);
}
