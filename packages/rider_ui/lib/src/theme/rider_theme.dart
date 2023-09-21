// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider_ui/rider_ui.dart';

/// {@template app_theme}
/// The Default App [ThemeData].
/// {@endtemplate}
class UITheme {
  /// {@macro app_theme}
  const UITheme();

  static void initialize() {
    GoogleFonts.config.allowRuntimeFetching = false;
  }

  ThemeData get materialTheme => ThemeData.light(useMaterial3: true);

  /// Default `ThemeData` for App UI.
  ThemeData get themeData {
    return materialTheme.copyWith(
      inputDecorationTheme: _inputDecorationTheme,
      appBarTheme: _appBarTheme,
      colorScheme: _colorScheme,
      scaffoldBackgroundColor: _colorScheme.background,
      bottomNavigationBarTheme: _bottomNavigationBarTheme,
    );
  }

  ColorScheme get _colorScheme {
    return ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: const Color(0xFF0094FF),
      background: const Color(0xFFF0F0F0),
      secondaryContainer: const Color(0xFF0094FF),
    );
  }

  SnackBarThemeData get _snackBarTheme {
    return SnackBarThemeData(
      contentTextStyle: UITextStyle.bodyText1.copyWith(
        color: UIColors.white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UISpacing.sm),
      ),
      actionTextColor: UIColors.lightBlue.shade300,
      backgroundColor: UIColors.black,
      elevation: 4,
      behavior: SnackBarBehavior.floating,
    );
  }

  Color get _backgroundColor => UIColors.white;

  AppBarTheme get _appBarTheme {
    return AppBarTheme(
      iconTheme: _iconTheme,
      titleTextStyle: _textTheme.titleLarge,
      // elevation: 0,
      // toolbarHeight: 64,
      backgroundColor: _colorScheme.secondaryContainer,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  BottomNavigationBarThemeData get _bottomNavigationBarTheme {
    return BottomNavigationBarThemeData(
      backgroundColor: _colorScheme.secondaryContainer,
      selectedItemColor: _colorScheme.primary,
      unselectedItemColor: _colorScheme.outline,
      showUnselectedLabels: true,
    );
  }

  IconThemeData get _iconTheme {
    return const IconThemeData(
      color: UIColors.onBackground,
    );
  }

  DividerThemeData get _dividerTheme {
    return const DividerThemeData(
      color: UIColors.outlineLight,
      space: UISpacing.lg,
      thickness: UISpacing.xxxs,
      indent: UISpacing.lg,
      endIndent: UISpacing.lg,
    );
  }

  TextTheme get _textTheme => GoogleFonts.poppinsTextTheme(uiTextTheme);

  /// The Content text theme based on [ContentTextStyle].
  static final contentTextTheme = GoogleFonts.poppinsTextTheme(
    TextTheme(
      displayLarge: ContentTextStyle.headline1,
      displayMedium: ContentTextStyle.headline2,
      displaySmall: ContentTextStyle.headline3,
      headlineMedium: ContentTextStyle.headline4,
      headlineSmall: ContentTextStyle.headline5,
      titleLarge: ContentTextStyle.headline6,
      titleMedium: ContentTextStyle.subtitle1,
      titleSmall: ContentTextStyle.subtitle2,
      bodyLarge: ContentTextStyle.bodyText1,
      bodyMedium: ContentTextStyle.bodyText2,
      labelLarge: ContentTextStyle.button,
      bodySmall: ContentTextStyle.caption,
      labelSmall: ContentTextStyle.overline,
    ).apply(
      bodyColor: UIColors.black,
      displayColor: UIColors.black,
      decorationColor: UIColors.black,
    ),
  );

  /// The UI text theme based on [UITextStyle].
  static final uiTextTheme = TextTheme(
    displayLarge: UITextStyle.headline1,
    displayMedium: UITextStyle.headline2,
    displaySmall: UITextStyle.headline3,
    headlineMedium: UITextStyle.headline4,
    headlineSmall: UITextStyle.headline5,
    titleLarge: UITextStyle.headline6,
    titleMedium: UITextStyle.subtitle1,
    titleSmall: UITextStyle.subtitle2,
    bodyLarge: UITextStyle.bodyText1,
    bodyMedium: UITextStyle.bodyText2,
    labelLarge: UITextStyle.button,
    bodySmall: UITextStyle.caption,
    labelSmall: UITextStyle.overline,
  ).apply(
    bodyColor: UIColors.black,
    displayColor: UIColors.black,
    decorationColor: UIColors.black,
  );

  InputDecorationTheme get _inputDecorationTheme {
    return const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 3, color: Colors.blue),
      ),
      // prefixStyle: themeData.inputDecorationTheme.prefixStyle?.copyWith(color: themeData.colorScheme.inversePrimary),
    );
    // return InputDecorationTheme(
    //   suffixIconColor: UIColors.mediumEmphasisSurface,
    //   prefixIconColor: UIColors.mediumEmphasisSurface,
    //   hoverColor: UIColors.inputHover,
    //   focusColor: UIColors.inputFocused,
    //   fillColor: UIColors.inputEnabled,
    //   enabledBorder: _textFieldBorder,
    //   focusedBorder: _textFieldBorder,
    //   disabledBorder: _textFieldBorder,
    //   hintStyle: UITextStyle.bodyText1.copyWith(
    //     color: UIColors.mediumEmphasisSurface,
    //   ),
    //   contentPadding: const EdgeInsets.all(UISpacing.lg),
    //   border: const UnderlineInputBorder(),
    //   filled: true,
    //   isDense: true,
    //   errorStyle: UITextStyle.caption,
    // );
  }

  ButtonThemeData get _buttonTheme {
    return ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UISpacing.sm),
      ),
    );
  }

  ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        padding: const EdgeInsets.symmetric(vertical: UISpacing.lg),
        textStyle: _textTheme.labelLarge,
        backgroundColor: UIColors.blue,
      ),
    );
  }

  TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: _textTheme.labelLarge?.copyWith(
          fontWeight: UIFontWeight.light,
        ),
        foregroundColor: UIColors.black,
      ),
    );
  }

  BottomSheetThemeData get _bottomSheetTheme {
    return const BottomSheetThemeData(
      backgroundColor: UIColors.modalBackground,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(UISpacing.lg),
          topRight: Radius.circular(UISpacing.lg),
        ),
      ),
    );
  }

  ListTileThemeData get _listTileTheme {
    return const ListTileThemeData(
      iconColor: UIColors.onBackground,
      contentPadding: EdgeInsets.all(UISpacing.lg),
    );
  }

  SwitchThemeData get _switchTheme {
    return SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return UIColors.darkAqua;
        }
        return UIColors.eerieBlack;
      }),
      trackColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return UIColors.primaryContainer;
        }
        return UIColors.paleSky;
      }),
    );
  }

  ProgressIndicatorThemeData get _progressIndicatorTheme {
    return const ProgressIndicatorThemeData(
      color: UIColors.darkAqua,
      circularTrackColor: UIColors.borderOutline,
    );
  }

  TabBarTheme get _tabBarTheme {
    return TabBarTheme(
      labelStyle: UITextStyle.button,
      labelColor: UIColors.darkAqua,
      labelPadding: const EdgeInsets.symmetric(
        horizontal: UISpacing.lg,
        vertical: UISpacing.md + UISpacing.xxs,
      ),
      unselectedLabelStyle: UITextStyle.button,
      unselectedLabelColor: UIColors.mediumEmphasisSurface,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 3,
          color: UIColors.darkAqua,
        ),
      ),
      indicatorSize: TabBarIndicatorSize.label,
    );
  }

  InputBorder get _textFieldBorder => const UnderlineInputBorder(
        borderSide: BorderSide(
          width: 1.5,
          color: UIColors.darkAqua,
        ),
      );
  ChipThemeData get _chipTheme {
    return const ChipThemeData(
      backgroundColor: UIColors.transparent,
    );
  }
}

/// {@template app_dark_theme}
/// Dark Mode App [ThemeData].
/// {@endtemplate}
class UIDarkTheme extends UITheme {
  /// {@macro app_dark_theme}
  const UIDarkTheme();

  @override
  ThemeData get materialTheme => ThemeData.dark(useMaterial3: true);

  @override
  ColorScheme get _colorScheme {
    return ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color(0xFF5eD4FC),
      primary: const Color(0xFF5eD4FC),
      onPrimary: const Color(0xFF003544),
      primaryContainer: const Color(0xFF004d61),
      onPrimaryContainer: const Color(0xFFb8eaff),
      secondary: const Color(0xFF5ed4fc),
      onSecondary: const Color(0xFF003544),
      secondaryContainer: const Color(0xFF004d61),
      onSecondaryContainer: const Color(0xFFb8eaff),
      tertiary: const Color(0xFF92f7bc),
      onTertiary: const Color(0xFF001c3b),
      tertiaryContainer: const Color(0xFFc3fada),
      onTertiaryContainer: const Color(0xFF78ffd6),
      background: const Color(0xFF001c3b),
      onBackground: const Color(0xFFd5e3ff),
      surface: const Color(0xFF001c3b),
      onSurface: const Color(0xFFd5e3ff),
      surfaceVariant: const Color(0xFF40484c),
      onSurfaceVariant: const Color(0xFFbfc8cc),
      outline: const Color(0xFF8a9296),
      inverseSurface: const Color(0xFFffe3c4),
      onInverseSurface: const Color(0xFF001c3b),
      inversePrimary: const Color(0xFFa12b03),
      // primaryColorDark: const Color(0xFF5eD4FC),
      // backgroundColor: const Color(0xFF003544),
    );
  }

  @override
  TextTheme get _textTheme {
    return UITheme.contentTextTheme.apply(
      bodyColor: UIColors.white,
      displayColor: UIColors.white,
      decorationColor: UIColors.white,
    );
  }

  @override
  SnackBarThemeData get _snackBarTheme {
    return SnackBarThemeData(
      contentTextStyle: UITextStyle.bodyText1.copyWith(
        color: UIColors.black,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UISpacing.sm),
      ),
      actionTextColor: UIColors.lightBlue.shade300,
      backgroundColor: UIColors.grey.shade300,
      elevation: 4,
      behavior: SnackBarBehavior.floating,
    );
  }

  @override
  TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: _textTheme.labelLarge?.copyWith(
          fontWeight: UIFontWeight.light,
        ),
        foregroundColor: UIColors.white,
      ),
    );
  }

  @override
  Color get _backgroundColor => UIColors.grey.shade900;

  @override
  IconThemeData get _iconTheme {
    return const IconThemeData(color: UIColors.white);
  }

  @override
  DividerThemeData get _dividerTheme {
    return const DividerThemeData(
      color: UIColors.onBackground,
      space: UISpacing.lg,
      thickness: UISpacing.xxxs,
      indent: UISpacing.lg,
      endIndent: UISpacing.lg,
    );
  }
}
