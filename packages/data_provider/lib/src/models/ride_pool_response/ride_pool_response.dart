// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:data_provider/data_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ride_pool_response.g.dart';

/// Ride Pool Response
@JsonSerializable(explicitToJson: true)
class RidePoolResponse {
  final List<Ride>? data;

  final PaginationMeta? meta;

  RidePoolResponse({
    this.data,
    this.meta,
  });

  factory RidePoolResponse.fromJson(Map<String, dynamic> json) => _$RidePoolResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RidePoolResponseToJson(this);
}
