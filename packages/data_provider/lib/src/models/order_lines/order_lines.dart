// ignore_for_file: sort_constructors_first, public_member_api_docs, lines_longer_than_80_chars
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_lines.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderLines extends Equatable {
  final int? id;

  @JsonKey(name: 'customer_id')
  final int? customerId;

  final String? status;

  final String? state;

  final String? reference;

  @JsonKey(name: 'is_payed')
  final bool? isPayed;

  @JsonKey(name: 'pay_method')
  final String? payMethod;

  @JsonKey(name: 'sub_total')
  final String? subTotal;

  @JsonKey(name: 'discount_total')
  final String? discountTotal;

  final double? total;

  @JsonKey(name: 'total_text')
  final String? totalText;

  @JsonKey(name: 'lines_count')
  final int? linesCount;

  final List<Line>? lines;

  const OrderLines({
    this.id,
    this.customerId,
    this.status,
    this.state,
    this.reference,
    this.isPayed,
    this.payMethod,
    this.subTotal,
    this.discountTotal,
    this.total,
    this.totalText,
    this.linesCount,
    this.lines,
  });

  factory OrderLines.fromJson(Map<String, dynamic> json) => _$OrderLinesFromJson(json);
  Map<String, dynamic> toJson() => _$OrderLinesToJson(this);

  @override
  List<Object?> get props => [
        id,
        customerId,
        status,
        state,
        reference,
        isPayed,
        payMethod,
        subTotal,
        discountTotal,
        total,
        totalText,
        linesCount,
        lines,
      ];

  OrderLines copyWith({
    int? id,
    int? customerId,
    String? status,
    String? state,
    String? reference,
    bool? isPayed,
    String? payMethod,
    String? subTotal,
    String? discountTotal,
    double? total,
    String? totalText,
    int? linesCount,
    List<Line>? lines,
  }) {
    return OrderLines(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      status: status ?? this.status,
      state: state ?? this.state,
      reference: reference ?? this.reference,
      isPayed: isPayed ?? this.isPayed,
      payMethod: payMethod ?? this.payMethod,
      subTotal: subTotal ?? this.subTotal,
      discountTotal: discountTotal ?? this.discountTotal,
      total: total ?? this.total,
      totalText: totalText ?? this.totalText,
      linesCount: linesCount ?? this.linesCount,
      lines: lines ?? this.lines,
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Line extends Equatable {
  final int? id;

  @JsonKey(name: 'unit_code')
  final String? unitCode;

  @JsonKey(name: 'unit_name')
  final String? unitName;

  final double? total;

  @JsonKey(name: 'total_text')
  final String? totalText;

  final int? quantity;

  final int? returned;

  final Product? product;

  const Line({
    this.id,
    this.unitCode,
    this.unitName,
    this.total,
    this.totalText,
    this.quantity,
    this.returned,
    this.product,
  });

  factory Line.fromJson(Map<String, dynamic> json) => _$LineFromJson(json);
  Map<String, dynamic> toJson() => _$LineToJson(this);

  @override
  List<Object?> get props => [
        id,
        unitCode,
        unitName,
        total,
        totalText,
        quantity,
        returned,
        product,
      ];

  Line copyWith({
    int? id,
    String? unitCode,
    String? unitName,
    double? total,
    String? totalText,
    int? quantity,
    int? returned,
    Product? product,
  }) {
    return Line(
      id: id ?? this.id,
      unitCode: unitCode ?? this.unitCode,
      unitName: unitName ?? this.unitName,
      total: total ?? this.total,
      totalText: totalText ?? this.totalText,
      quantity: quantity ?? this.quantity,
      returned: returned ?? this.returned,
      product: product ?? this.product,
    );
  }
}

@JsonSerializable()
class Product extends Equatable {
  final int? id;

  final String? code;

  @JsonKey(name: 'main_unit')
  final String? mainUnit;

  @JsonKey(name: 'short_name')
  final String? shortName;

  @JsonKey(name: 'short_description')
  final String? shortDescription;

  @JsonKey(name: 'is_bundle')
  final bool? isBundle;

  @JsonKey(name: 'thumb_pic')
  final String? thumbPic;

  const Product({
    this.id,
    this.code,
    this.mainUnit,
    this.shortName,
    this.shortDescription,
    this.isBundle,
    this.thumbPic,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object?> get props => [
        id,
        code,
        mainUnit,
        shortName,
        shortDescription,
        isBundle,
        thumbPic,
      ];
}
