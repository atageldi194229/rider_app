// ignore_for_file: sort_constructors_first, public_member_api_docs, lines_longer_than_80_chars

import 'package:data_provider/data_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'line_status_response.g.dart';

/// The Line Status Response Model
@JsonSerializable(explicitToJson: true)
class LineStatusResponse {
  /// Constructor
  LineStatusResponse({
    this.success,
    this.data,
  });

  /// Status
  final bool? success;

  /// Staff data
  final Staff? data;

  factory LineStatusResponse.fromJson(Map<String, dynamic> json) => _$LineStatusResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LineStatusResponseToJson(this);
}
