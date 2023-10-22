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

  /// Reference
  final String? reference;

  /// Order state
  @JsonKey(name: 'order_state')
  final String? orderState;

  /// Order state translated
  @JsonKey(name: 'order_state_trans')
  final String? orderStateTranslated;

  /// Order state color
  @JsonKey(name: 'order_state_color')
  final String? orderStateColor;

  /// Point status
  @JsonKey(name: 'point_status')
  final PointStatus? pointStatus;

  /// Point status translation
  @JsonKey(name: 'point_status_trans')
  final String? pointStatusTranslation;

  /// Point status color
  @JsonKey(name: 'point_state_color') // This is not mistaken
  final String? pointStatusColor;

  /// Total text
  @JsonKey(name: 'total_text')
  final String? totalText;

  /// Items count
  @JsonKey(name: 'items_count')
  final int? itemsCount;

  /// Slot number
  @JsonKey(name: 'slot_number')
  final int? slotNumber;

  /// Duration text
  @JsonKey(name: 'duration_text')
  final String? durationText;

  /// Distance text
  @JsonKey(name: 'distance_text')
  final String? distanceText;

  /// Customer name
  @JsonKey(name: 'customer_name')
  final String? customerName;

  /// Customer phone
  @JsonKey(name: 'customer_phone')
  final String? customerPhone;

  /// Has notes
  @JsonKey(name: 'has_notes')
  final bool? hasNotes;

  /// Notes
  @JsonKey(name: 'notes')
  final String? notes;

  /// Placed at
  @JsonKey(name: 'placed_at')
  final String? placedAt;

  /// Deadline
  final String? deadline;

  /// Is disabled
  final bool? disabled;

  /// Service type MEGA, MINI
  @JsonKey(name: 'service_type')
  final String? serviceType;

  /// Labels
  final List<String>? labels;

  /// Customer address
  final Address? address;

  Order({
    this.reference,
    this.totalText,
    this.itemsCount,
    this.notes,
    this.pointId,
    this.orderId,
    this.orderState,
    this.orderStateTranslated,
    this.orderStateColor,
    this.pointStatus,
    this.pointStatusTranslation,
    this.pointStatusColor,
    this.slotNumber,
    this.distanceText,
    this.durationText,
    this.customerName,
    this.customerPhone,
    this.hasNotes,
    this.placedAt,
    this.deadline,
    this.disabled,
    this.serviceType,
    this.labels,
    this.address,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
