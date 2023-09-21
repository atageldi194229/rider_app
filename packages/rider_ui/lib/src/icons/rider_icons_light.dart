import 'package:rider_ui/rider_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UIIconsLight extends UIIcon {
  @override
  SvgPicture emailOutline({double? size, Color? color}) {
    return super.emailOutline(
      color: color ?? UIColors.black,
      size: size ?? 14,
    );
  }

  @override
  SvgPicture splashLogo({double? size, Color? color}) {
    return super.splashLogo(
      color: color ?? UIColors.black,
      size: size ?? 14,
    );
  }

  @override
  SvgPicture backIcon({double? size, Color? color}) {
    return super.backIcon(
      color: color ?? UIColors.black,
      size: size ?? 14,
    );
  }
}
