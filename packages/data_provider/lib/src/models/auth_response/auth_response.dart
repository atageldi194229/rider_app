// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:data_provider/data_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

/// Auth Response
@JsonSerializable(explicitToJson: true)
class AuthResponse {
  /// Success indicator
  final bool? success;

  /// Auth data
  final AuthData? data;

  AuthResponse({
    this.success,
    this.data,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

/// Auth data
@JsonSerializable(explicitToJson: true)
class AuthData {
  /// Access token
  @JsonKey(name: 'access_token')
  final String? accessToken;

  /// Staff
  final Staff? staff;

  AuthData({
    this.accessToken,
    this.staff,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) => _$AuthDataFromJson(json);
  Map<String, dynamic> toJson() => _$AuthDataToJson(this);
}
