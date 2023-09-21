// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:data_provider/data_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_lines_response.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderLinesResponse {
  final OrderLines? data;

  OrderLinesResponse({
    this.data,
  });

  factory OrderLinesResponse.fromJson(Map<String, dynamic> json) => _$OrderLinesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderLinesResponseToJson(this);
}
