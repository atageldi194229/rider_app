import 'package:asman_rider/authentication/authentication.dart';
import 'package:asman_rider/login/login.dart';
import 'package:asman_rider/rides/rides.dart';
import 'package:asman_rider/splash/splash.dart';
import 'package:flutter/widgets.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AuthenticationStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AuthenticationStatus.authenticated:
      return [RidesPage.page()];
    case AuthenticationStatus.unauthenticated:
      return [LoginPage.page()];
    case AuthenticationStatus.initial:
      return [SplashPage.page()];
  }
}
