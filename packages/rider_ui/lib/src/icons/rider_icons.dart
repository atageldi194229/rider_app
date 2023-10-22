import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rider_ui/src/generated/assets.gen.dart';

abstract class UIIcon {
  SvgPicture emailOutline({double? size, Color? color}) {
    return Assets.icons.emailOutline.svg(
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      height: size ?? 14,
      width: size ?? 14,
    );
  }

  SvgPicture sklad({double? size, Color? color}) {
    return Assets.icons.sklad.svg(
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      fit: BoxFit.cover,
      clipBehavior: Clip.none,
      height: size ?? 14,
      width: size ?? 14,
    );
  }

  SvgPicture splashLogo({double? size, Color? color}) {
    return Assets.icons.splashLogo.svg(
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      height: size ?? 14,
      width: size ?? 14,
    );
  }

  SvgPicture backIcon({double? size, Color? color}) {
    return Assets.icons.backIcon.svg(
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      height: size ?? 14,
      width: size ?? 14,
    );
  }
}
