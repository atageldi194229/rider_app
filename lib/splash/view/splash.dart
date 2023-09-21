import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider_ui/rider_ui.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: SplashPage());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: UIColors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            theme.icons.splashLogo(size: (150 / 375).sw, color: UIColors.white),
            const SizedBox(height: UISpacing.md),
            Text('AsmanExpress', style: theme.primaryTextTheme.headlineMedium?.copyWith(color: UIColors.white)),
            const SizedBox(height: UISpacing.sm),
            Text('Rider App', style: theme.primaryTextTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}
