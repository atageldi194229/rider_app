// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:data_provider/data_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderDetail {
  final int? id;

  @JsonKey(name: 'point_id')
  final int? pointId;

  @JsonKey(name: 'order_state')
  final String? orderState;

  @JsonKey(name: 'point_status')
  final PointStatus? pointStatus;

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

  final Address? address;

  OrderDetail({
    this.id,
    this.pointId,
    this.orderState,
    this.pointStatus,
    this.zoneName,
    this.customerName,
    this.customerPhone,
    this.deadline,
    this.linesCount,
    this.totalWeight,
    this.payMethod,
    this.notes,
    this.address,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => _$OrderDetailFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDetailToJson(this);
}
