// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:data_provider/data_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address {
  /// The address
  final String? address;

  /// Title
  final String? title;

  /// Building
  final String? building;

  /// Floor
  final String? floor;

  /// Door
  final String? door;

  /// Coordinates
  final Coordinates? coordinates;

  Address({
    this.address,
    this.title,
    this.building,
    this.floor,
    this.door,
    this.coordinates,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
