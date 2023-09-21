import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';
import 'package:rider_ui/src/generated/assets.gen.dart';

class UILoginPageBackground extends StatelessWidget {
  const UILoginPageBackground({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            const SizedBox(height: UISpacing.xxxlg),
            Assets.images.asmanExpress.image(),
            const SizedBox(height: UISpacing.xxlg),
            Assets.images.loginPageAsset.image(),
            const Spacer(),
          ],
        ),
        _OvalClipWidget(child: child),
      ],
    );
  }
}

class _OvalClipWidget extends StatelessWidget {
  const _OvalClipWidget({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        const Spacer(),
        ClipPath(
          clipper: HalfOvalClipper(top: 60.0),
          child: Container(
            color: Theme.of(context).colorScheme.surface,
            height: size.height * 0.5,
            child: Column(
              children: [
                const Spacer(),
                child,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class HalfOvalClipper extends CustomClipper<Path> {
  HalfOvalClipper({
    double top = 0,
    double bottom = 0,
  })  : _top = top,
        _bottom = bottom;

  final double _top;
  final double _bottom;

  @override
  getClip(Size size) {
    double w = size.width;
    double h = size.height;

    // Offset topLeftCorner = Offset(0, _top);
    // Offset bottomLeftCorner = Offset(0, h - _bottom);
    // Offset topRightCorner = Offset(w, h - _bottom);
    // Offset bottomRightCorner = Offset(w, _top);

    return Path()
      ..moveTo(0, _top)
      ..lineTo(0, h - _bottom)
      ..quadraticBezierTo(
        size.width * .5,
        h,
        w,
        h - _bottom,
      )
      ..lineTo(w, h - _bottom)
      ..lineTo(w, _top)
      ..quadraticBezierTo(
        size.width * .5,
        0,
        0,
        _top,
      )
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
