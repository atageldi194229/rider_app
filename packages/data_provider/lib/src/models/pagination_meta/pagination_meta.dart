// ignore_for_file: sort_constructors_first, public_member_api_docs, lines_longer_than_80_chars
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_meta.g.dart';

@JsonSerializable()
class PaginationMeta extends Equatable {
  @JsonKey(name: 'current_page')
  final int? currentPage;

  @JsonKey(name: 'last_page')
  final int? lastPage;

  @JsonKey(name: 'per_page')
  final int? perPage;

  final int? total;

  const PaginationMeta({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) => _$PaginationMetaFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationMetaToJson(this);

  @override
  List<Object?> get props => [
        currentPage,
        lastPage,
        perPage,
        total,
      ];
}
