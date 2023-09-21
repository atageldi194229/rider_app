// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:data_provider/data_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'history_response.g.dart';

/// Auth Response
@JsonSerializable(explicitToJson: true)
class HistoryResponse {
  /// Auth data
  final List<HistoryItem>? data;

  HistoryResponse({
    this.data,
  });

  factory HistoryResponse.fromJson(Map<String, dynamic> json) => _$HistoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryResponseToJson(this);
}
