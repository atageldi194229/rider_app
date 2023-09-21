// ignore_for_file: public_member_api_docs
import 'package:json_annotation/json_annotation.dart';

/// Ride Status
enum RideStatus {
  @JsonValue('PENDING')
  pending,
  @JsonValue('ASSIGNED')
  assigned,
  @JsonValue('STARTED')
  started,
  @JsonValue('COMPLETED')
  completed,
  @JsonValue('PAUSED')
  paused,
  @JsonValue('TRANSFERED')
  transfered,
  @JsonValue('CANCELED')
  canceled,
}

/// Point Status
enum PointStatus {
  @JsonValue('CANCELED')
  canceled,
  @JsonValue('PENDING')
  pending,
  @JsonValue('ARRIVED')
  arrived,
  @JsonValue('COMPLETED')
  completed,
}
