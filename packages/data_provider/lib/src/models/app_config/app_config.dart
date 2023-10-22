// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:json_annotation/json_annotation.dart';

part 'app_config.g.dart';

/// Auth Response
@JsonSerializable()
class AppConfig {
  @JsonKey(name: 'grpc_seconds')
  final int? grpcSeconds;

  @JsonKey(name: 'grpc_url')
  final String? grpcUrl;

  AppConfig({
    this.grpcSeconds,
    this.grpcUrl,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) => _$AppConfigFromJson(json);
  Map<String, dynamic> toJson() => _$AppConfigToJson(this);
}
