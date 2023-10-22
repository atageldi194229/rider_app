// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:data_provider/data_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderDetail {
  final int? id;

  @JsonKey(name: 'point_id')
  final int? pointId;

  final String? reference;

  @JsonKey(name: 'order_state')
  final String? orderState;

  @JsonKey(name: 'order_state_trans')
  final String? orderStateTranslated;

  @JsonKey(name: 'order_state_color')
  final String? orderStateColor;

  @JsonKey(name: 'point_status')
  final PointStatus? pointStatus;

  @JsonKey(name: 'point_status_trans')
  final String? pointStatusTranslated;

  @JsonKey(name: 'point_status_color')
  final String? pointStatusColor;

  @JsonKey(name: 'zone_name')
  final String? zoneName;

  @JsonKey(name: 'customer_name')
  final String? customerName;

  @JsonKey(name: 'customer_phone')
  final String? customerPhone;

  final String? deadline;

  @JsonKey(name: 'lines_count')
  final int? linesCount;

  @JsonKey(name: 'total_weight')
  final int? totalWeight;

  @JsonKey(name: 'pay_method')
  final String? payMethod;

  final String? notes;

  final String? info;

  final bool? disabled;

  final Address? address;

  final List<OrderDetailAttribute>? attributes;

  OrderDetail({
    this.attributes,
    this.disabled,
    this.id,
    this.pointId,
    this.reference,
    this.orderState,
    this.orderStateTranslated,
    this.orderStateColor,
    this.pointStatus,
    this.pointStatusTranslated,
    this.pointStatusColor,
    this.zoneName,
    this.customerName,
    this.customerPhone,
    this.deadline,
    this.linesCount,
    this.totalWeight,
    this.payMethod,
    this.notes,
    this.info,
    this.address,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => _$OrderDetailFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDetailToJson(this);
}

@JsonSerializable()
class OrderDetailAttribute {
  /// key
  final String? name;

  /// value
  final dynamic value;

  OrderDetailAttribute({
    required this.name,
    required this.value,
  });

  factory OrderDetailAttribute.fromJson(Map<String, dynamic> json) => _$OrderDetailAttributeFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDetailAttributeToJson(this);
}
