// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:data_provider/data_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_detail_response.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderDetailResponse {
  final OrderDetail? data;

  OrderDetailResponse({
    this.data,
  });

  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) => _$OrderDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDetailResponseToJson(this);
}
