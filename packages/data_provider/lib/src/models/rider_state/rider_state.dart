// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rider_state.g.dart';

/// [RiderState]
/// Profile information
/// Last active trip
/// Configuration can be found
@JsonSerializable(explicitToJson: true)
class RiderState extends Equatable {
  const RiderState(
    this.id,
    this.code,
    this.warehouseId,
    this.warehouseName,
    this.firstname,
    this.lastname,
    this.phone,
    this.dateOfBirth,
    this.status,
    this.rating,
    this.activeRideId,
    this.config,
  );

  final int? id;
  final String? code;

  @JsonKey(name: 'warehouse_id')
  final int? warehouseId;

  @JsonKey(name: 'warehouse_name')
  final String? warehouseName;

  final String? firstname;
  final String? lastname;
  final String? phone;

  @JsonKey(name: 'date_of_birth')
  final String? dateOfBirth;

  final int? status;

  final String? rating;

  @JsonKey(name: 'active_ride', fromJson: _activeRideIdFromJson)
  final int? activeRideId;

  final RiderConfiguration? config;

  factory RiderState.fromJson(Map<String, dynamic> json) => _$RiderStateFromJson(json);
  Map<String, dynamic> toJson() => _$RiderStateToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      code,
      warehouseId,
      warehouseName,
      firstname,
      lastname,
      phone,
      dateOfBirth,
      status,
      rating,
      activeRideId,
      config,
    ];
  }
}

int? _activeRideIdFromJson(Map<String, dynamic> m) {
  return m['id'] == null ? null : m['id'] as int;
}

/// Rider Configuration
///
/// [grpsSeconds] interval seconds to send the current location
@JsonSerializable()
class RiderConfiguration {
  RiderConfiguration({
    this.grpsSeconds,
  });

  final int? grpsSeconds;

  factory RiderConfiguration.fromJson(Map<String, dynamic> json) => _$RiderConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$RiderConfigurationToJson(this);
}
