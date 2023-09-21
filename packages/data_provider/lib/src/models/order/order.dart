// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_provider/data_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

/// Order model
@JsonSerializable(explicitToJson: true)
class Order {
  /// Point ID
  @JsonKey(name: 'point_id')
  final int? pointId;

  /// Order ID
  @JsonKey(name: 'order_id')
  final int? orderId;

  /// Order state
  @JsonKey(name: 'order_state')
  final String? orderState;

  /// Point status
  @JsonKey(name: 'point_status')
  final PointStatus? pointStatus;

  /// Point status translation
  @JsonKey(name: 'point_status_trans')
  final String? pointStatusTranslation;

  /// Slot number
  @JsonKey(name: 'slot_number')
  final int? slotNumber;

  /// Distance text
  @JsonKey(name: 'distance_text')
  final String? distanceText;

  /// Duration text
  @JsonKey(name: 'duration_text')
  final String? durationText;

  /// Customer name
  @JsonKey(name: 'customer_name')
  final String? customerName;

  /// Customer phone
  @JsonKey(name: 'customer_phone')
  final String? customerPhone;

  /// Has notes
  @JsonKey(name: 'has_notes')
  final bool? hasNotes;

  /// Placed at
  @JsonKey(name: 'placed_at')
  final String? placedAt;

  /// Deadline
  final String? deadline;

  /// Service type MEGA, MINI
  @JsonKey(name: 'service_type')
  final String? serviceType;

  /// Labels
  final List<String>? labels;

  /// Customer address
  final Address? address;

  Order({
    this.pointId,
    this.orderId,
    this.orderState,
    this.pointStatus,
    this.pointStatusTranslation,
    this.slotNumber,
    this.distanceText,
    this.durationText,
    this.customerName,
    this.customerPhone,
    this.hasNotes,
    this.placedAt,
    this.deadline,
    this.serviceType,
    this.labels,
    this.address,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
