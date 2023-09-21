// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:json_annotation/json_annotation.dart';

part 'history_item.g.dart';

/// Auth Response
@JsonSerializable()
class HistoryItem {
  final int? id;

  @JsonKey(name: 'zone_id')
  final int? zoneId;

  @JsonKey(name: 'distance_text')
  final String? distanceText;

  @JsonKey(name: 'duration_text')
  final String? durationText;

  final String? status;

  @JsonKey(name: 'status_trans')
  final String? statusTrans;

  @JsonKey(name: 'started_at')
  final DateTime? startedAt;

  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;

  @JsonKey(name: 'diff_in_min')
  final num? diffInMin;

  HistoryItem({
    this.id,
    this.zoneId,
    this.distanceText,
    this.durationText,
    this.status,
    this.statusTrans,
    this.startedAt,
    this.completedAt,
    this.diffInMin,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) => _$HistoryItemFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryItemToJson(this);
}
