// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_provider/data_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ride_detail_response.g.dart';

/// Ride detail response
@JsonSerializable(explicitToJson: true)
class RideDetailResponse {
  /// Success indicator
  final bool? success;

  /// Ride detail
  final RideDetail? data;

  RideDetailResponse({
    this.success,
    this.data,
  });

  // ignore: lines_longer_than_80_chars
  factory RideDetailResponse.fromJson(Map<String, dynamic> json) => _$RideDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RideDetailResponseToJson(this);
}
