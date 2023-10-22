// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:data_provider/data_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_config_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AppConfigResponse {
  final AppConfig? data;

  AppConfigResponse({
    this.data,
  });

  factory AppConfigResponse.fromJson(Map<String, dynamic> json) => _$AppConfigResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AppConfigResponseToJson(this);
}
