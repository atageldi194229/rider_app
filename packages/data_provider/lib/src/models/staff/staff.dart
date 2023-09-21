// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'staff.g.dart';

/// Staff
@JsonSerializable()
class Staff {
  /// Constructor
  Staff({
    this.id,
    this.code,
    this.firstName,
    this.lastname,
    this.phone,
    this.servicePhone,
    this.email,
    this.locale,
    this.dateOfBirth,
    this.warehouseId,
    this.status,
    this.rating,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  /// Staff id
  final int? id;

  /// Staff code
  final String? code;

  /// Staff first name
  @JsonKey(name: 'firstname')
  final String? firstName;

  /// Staff last name
  final String? lastname;

  /// Staff phone number
  final String? phone;

  /// Service phone number
  @JsonKey(name: 'service_phone')
  final String? servicePhone;

  /// Staff email address
  final String? email;

  /// App language
  final String? locale;

  /// Staff date of birth
  @JsonKey(name: 'date_of_birth')
  final String? dateOfBirth;

  /// Warehouse id
  @JsonKey(name: 'warehouse_id')
  final int? warehouseId;

  /// Online status of staff
  /// if value 1 then staff status online
  final int? status;

  /// Rating
  final String? rating;

  /// Created time
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// Updated time
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  /// Deleted time
  @JsonKey(name: 'deleted_at')
  final String? deletedAt;

  /// From Json
  factory Staff.fromJson(Map<String, dynamic> json) => _$StaffFromJson(json);

  /// To JSON
  Map<String, dynamic> toJson() => _$StaffToJson(this);
}
