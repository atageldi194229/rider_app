// ignore_for_file: lines_longer_than_80_chars, sort_constructors_first, public_member_api_docs

import 'package:data_provider/data_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'daily_order_response.g.dart';

/// DailyOrderResponse
@JsonSerializable()
class DailyOrderResponse {
  /// Contructor
  const DailyOrderResponse({
    this.success,
    this.data,
  });

  /// Success
  final bool? success;

  /// Data
  final List<DailyOrder>? data;

  // final int? earnings;

  factory DailyOrderResponse.fromJson(Map<String, dynamic> json) => _$DailyOrderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DailyOrderResponseToJson(this);
}
