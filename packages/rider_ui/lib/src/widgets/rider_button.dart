import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';

/// {@template app_button}
/// Button with text displayed in the application.
/// {@endtemplate}
class UIButton extends StatelessWidget {
  /// {@macro app_button}
  const UIButton._({
    required this.child,
    this.onPressed,
    Color? buttonColor,
    Color? disabledButtonColor,
    Color? foregroundColor,
    Color? disabledForegroundColor,
    BorderSide? borderSide,
    double? elevation,
    TextStyle? textStyle,
    Size? maximumSize,
    Size? minimumSize,
    EdgeInsets? padding,
    super.key,
  })  : _buttonColor = buttonColor ?? Colors.white,
        _disabledButtonColor = disabledButtonColor ?? UIColors.disabledButton,
        _borderSide = borderSide,
        _foregroundColor = foregroundColor ?? UIColors.black,
        _disabledForegroundColor = disabledForegroundColor ?? UIColors.disabledForeground,
        _elevation = elevation ?? 0,
        _textStyle = textStyle,
        _maximumSize = maximumSize ?? _defaultMaximumSize,
        _minimumSize = minimumSize ?? _defaultMinimumSize,
        _padding = padding ?? _defaultPadding;

  /// Filled black button.
  const UIButton.black({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: UIColors.black,
          child: child,
          foregroundColor: UIColors.white,
          elevation: elevation,
          textStyle: textStyle,
        );

  /// Filled blue dress button.
  const UIButton.blueDress({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: UIColors.blueDress,
          child: child,
          foregroundColor: UIColors.white,
          elevation: elevation,
          textStyle: textStyle,
        );

  /// Filled crystal blue button.
  const UIButton.crystalBlue({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: UIColors.crystalBlue,
          child: child,
          foregroundColor: UIColors.white,
          elevation: elevation,
          textStyle: textStyle,
        );

  /// Filled red wine button.
  const UIButton.redWine({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: UIColors.redWine,
          child: child,
          foregroundColor: UIColors.white,
          elevation: elevation,
          textStyle: textStyle,
        );

  /// Filled secondary button.
  const UIButton.secondary({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
    Color? disabledButtonColor,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: UIColors.secondary,
          child: child,
          foregroundColor: UIColors.white,
          disabledButtonColor: disabledButtonColor ?? UIColors.disabledSurface,
          elevation: elevation,
          textStyle: textStyle,
          padding: _smallPadding,
          maximumSize: _smallMaximumSize,
          minimumSize: _smallMinimumSize,
        );

  /// Filled dark aqua button.
  const UIButton.darkAqua({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: UIColors.darkAqua,
          child: child,
          foregroundColor: UIColors.white,
          elevation: elevation,
          textStyle: textStyle,
        );

  /// Outlined white button.
  const UIButton.outlinedWhite({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          child: child,
          buttonColor: UIColors.white,
          borderSide: const BorderSide(
            color: UIColors.pastelGrey,
          ),
          elevation: elevation,
          foregroundColor: UIColors.lightBlack,
          textStyle: textStyle,
        );

  /// Outlined transparent dark aqua button.
  const UIButton.outlinedTransparentDarkAqua({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          child: child,
          buttonColor: UIColors.transparent,
          borderSide: const BorderSide(
            color: UIColors.paleSky,
          ),
          elevation: elevation,
          foregroundColor: UIColors.darkAqua,
          textStyle: textStyle,
        );

  /// Outlined transparent white button.
  const UIButton.outlinedTransparentWhite({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          child: child,
          buttonColor: UIColors.transparent,
          borderSide: const BorderSide(
            color: UIColors.white,
          ),
          elevation: elevation,
          foregroundColor: UIColors.white,
          textStyle: textStyle,
        );

  /// Filled transparent dark aqua button.
  const UIButton.transparentDarkAqua({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          child: child,
          buttonColor: UIColors.transparent,
          elevation: elevation,
          foregroundColor: UIColors.darkAqua,
          textStyle: textStyle,
        );

  /// Filled transparent white button.
  const UIButton.transparentWhite({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          child: child,
          disabledButtonColor: UIColors.transparent,
          buttonColor: UIColors.transparent,
          elevation: elevation,
          foregroundColor: UIColors.white,
          disabledForegroundColor: UIColors.white,
          textStyle: textStyle,
        );

  /// Filled small red wine blue button.
  const UIButton.smallRedWine({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: UIColors.redWine,
          child: child,
          foregroundColor: UIColors.white,
          elevation: elevation,
          maximumSize: _smallMaximumSize,
          minimumSize: _smallMinimumSize,
          padding: _smallPadding,
        );

  /// Filled small transparent button.
  const UIButton.smallDarkAqua({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: UIColors.darkAqua,
          child: child,
          foregroundColor: UIColors.white,
          elevation: elevation,
          maximumSize: _smallMaximumSize,
          minimumSize: _smallMinimumSize,
          padding: _smallPadding,
        );

  /// Filled small transparent button.
  const UIButton.smallTransparent({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: UIColors.transparent,
          child: child,
          foregroundColor: UIColors.darkAqua,
          elevation: elevation,
          maximumSize: _smallMaximumSize,
          minimumSize: _smallMinimumSize,
          padding: _smallPadding,
        );

  /// Filled small transparent button.
  const UIButton.smallOutlineTransparent({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: UIColors.transparent,
          child: child,
          borderSide: const BorderSide(
            color: UIColors.paleSky,
          ),
          foregroundColor: UIColors.darkAqua,
          elevation: elevation,
          maximumSize: _smallMaximumSize,
          minimumSize: _smallMinimumSize,
          padding: _smallPadding,
        );

  /// The maximum size of the small variant of the button.
  static const _smallMaximumSize = Size(double.infinity, 40);

  /// The minimum size of the small variant of the button.
  static const _smallMinimumSize = Size(0, 40);

  /// The maximum size of the button.
  static const _defaultMaximumSize = Size(double.infinity, 56);

  /// The minimum size of the button.
  static const _defaultMinimumSize = Size(double.infinity, 56);

  /// The padding of the small variant of the button.
  static const _smallPadding = EdgeInsets.symmetric(horizontal: UISpacing.xlg);

  /// The padding of the the button.
  static const _defaultPadding = EdgeInsets.symmetric(vertical: UISpacing.lg);

  /// [VoidCallback] called when button is pressed.
  /// Button is disabled when null.
  final VoidCallback? onPressed;

  /// A background color of the button.
  ///
  /// Defaults to [Colors.white].
  final Color _buttonColor;

  /// A disabled background color of the button.
  ///
  /// Defaults to [UIColors.disabledButton].
  final Color? _disabledButtonColor;

  /// Color of the text, icons etc.
  ///
  /// Defaults to [UIColors.black].
  final Color _foregroundColor;

  /// Color of the disabled text, icons etc.
  ///
  /// Defaults to [UIColors.disabledForeground].
  final Color _disabledForegroundColor;

  /// A border of the button.
  final BorderSide? _borderSide;

  /// Elevation of the button.
  final double _elevation;

  /// [TextStyle] of the button text.
  ///
  /// Defaults to [TextTheme.labelLarge].
  final TextStyle? _textStyle;

  /// The maximum size of the button.
  ///
  /// Defaults to [_defaultMaximumSize].
  final Size _maximumSize;

  /// The minimum size of the button.
  ///
  /// Defaults to [_defaultMinimumSize].
  final Size _minimumSize;

  /// The padding of the button.
  ///
  /// Defaults to [EdgeInsets.zero].
  final EdgeInsets _padding;

  /// [Widget] displayed on the button.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textStyle = _textStyle ?? Theme.of(context).textTheme.labelLarge;

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        maximumSize: MaterialStateProperty.all(_maximumSize),
        padding: MaterialStateProperty.all(_padding),
        minimumSize: MaterialStateProperty.all(_minimumSize),
        textStyle: MaterialStateProperty.all(textStyle),
        backgroundColor: onPressed == null ? MaterialStateProperty.all(_disabledButtonColor) : MaterialStateProperty.all(_buttonColor),
        elevation: MaterialStateProperty.all(_elevation),
        foregroundColor: onPressed == null ? MaterialStateProperty.all(_disabledForegroundColor) : MaterialStateProperty.all(_foregroundColor),
        side: MaterialStateProperty.all(_borderSide),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
      child: child,
    );
  }
}
