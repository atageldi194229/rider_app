// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars, avoid_dynamic_calls

import 'package:data_provider/data_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rider_state_response.g.dart';

@JsonSerializable(explicitToJson: true)
class RiderStateResponse {
  RiderStateResponse({
    this.data,
  });

  final RiderState? data;

  factory RiderStateResponse.fromJson(Map<String, dynamic> json) => _$RiderStateResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RiderStateResponseToJson(this);
}
