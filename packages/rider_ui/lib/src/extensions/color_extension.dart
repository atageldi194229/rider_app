import 'package:flutter/material.dart';

/// Color Extension for String
///
/// For example: ```dart
/// "#5596f7".toColor() // -> Color("0xFF5596f7")
/// "#!@#$596f7".toColor() // -> null
/// ```
extension ColorExtension on String {
  Color? toColor() {
    var hexColor = replaceAll("#", "");

    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }

    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }

    return null;
  }
}
