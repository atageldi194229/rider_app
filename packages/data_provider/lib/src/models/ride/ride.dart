// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:data_provider/data_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ride.g.dart';

/// Ride model
@JsonSerializable(explicitToJson: true)
class Ride {
  /// ID
  final int? id;

  /// Warehouse ID
  @JsonKey(name: 'warehouse_id')
  final int? warehouseId;

  /// Zone ID
  @JsonKey(name: 'zone_id')
  final int? zoneId;

  /// Zone name
  @JsonKey(name: 'zone_name')
  final String? zoneName;

  /// Rider ID
  @JsonKey(name: 'rider_id')
  final int? riderId;

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

  /// Points count
  @JsonKey(name: 'points_count')
  final int? pointsCount;

  /// Estimated at
  @JsonKey(name: 'estimated_at')
  final String? estimatedAt;

  /// Created at
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// Start deadline
  @JsonKey(name: 'start_deadline')
  final DateTime? startDeadline;

  /// Complete deadline
  @JsonKey(name: 'complete_deadline')
  final DateTime? completeDeadline;

  /// Points
  final List<RidePoint>? points;

  Ride({
    this.id,
    this.warehouseId,
    this.zoneId,
    this.zoneName,
    this.riderId,
    this.distanceText,
    this.durationText,
    this.status,
    this.statusTranslated,
    this.statusColor,
    this.pointsCount,
    this.estimatedAt,
    this.createdAt,
    this.startDeadline,
    this.completeDeadline,
    this.points,
  });

  factory Ride.fromJson(Map<String, dynamic> json) => _$RideFromJson(json);
  Map<String, dynamic> toJson() => _$RideToJson(this);
}

/// Ride model
@JsonSerializable()
class RidePoint {
  /// ID
  final int? id;

  final String? reference;

  @JsonKey(name: 'order_state_trans')
  final String? orderStateTranslated;

  @JsonKey(name: 'order_state_color')
  final String? orderStateColor;

  /// Deadline
  final DateTime? deadline;

  /// Address
  final String? address;

  RidePoint({
    this.id,
    this.reference,
    this.orderStateTranslated,
    this.orderStateColor,
    this.deadline,
    this.address,
  });

  factory RidePoint.fromJson(Map<String, dynamic> json) => _$RidePointFromJson(json);
  Map<String, dynamic> toJson() => _$RidePointToJson(this);
}
