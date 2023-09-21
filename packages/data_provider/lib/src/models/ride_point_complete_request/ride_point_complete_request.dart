// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:json_annotation/json_annotation.dart';

part 'ride_point_complete_request.g.dart';

/// Ride detail response
@JsonSerializable()
class RidePointCompleteRequest {
  @JsonKey(name: 'point_id')
  final int? pointId;

  @JsonKey(name: 'pay_method')
  final String? payMethod;

  @JsonKey(name: 'cash_payed')
  final double? cashPayed;

  @JsonKey(name: 'card_payed')
  final double? cardPayed;

  @JsonKey(name: 'terminal_code')
  final String? terminalCode;

  RidePointCompleteRequest({
    this.pointId,
    this.payMethod,
    this.cashPayed,
    this.cardPayed,
    this.terminalCode,
  });

  factory RidePointCompleteRequest.fromJson(Map<String, dynamic> json) => _$RidePointCompleteRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RidePointCompleteRequestToJson(this);
}
