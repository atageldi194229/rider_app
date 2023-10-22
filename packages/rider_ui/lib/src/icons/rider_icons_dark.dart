import 'package:rider_ui/rider_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UIIconsDark extends UIIcon {
  @override
  SvgPicture emailOutline({double? size, Color? color}) {
    return super.emailOutline(
      color: color ?? UIColors.white,
      size: size ?? 14,
    );
  }

  @override
  SvgPicture sklad({double? size, Color? color}) {
    return super.sklad(
      color: color ?? UIColors.white,
      size: size ?? 14,
    );
  }

  @override
  SvgPicture splashLogo({double? size, Color? color}) {
    return super.splashLogo(
      color: color ?? UIColors.white,
      size: size ?? 14,
    );
  }

  @override
  SvgPicture backIcon({double? size, Color? color}) {
    return super.backIcon(
      color: color ?? UIColors.white,
      size: size ?? 14,
    );
  }
}
