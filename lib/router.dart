import 'package:flutter/material.dart';
import 'package:hairvibe/views/auth_screen.dart';
import 'package:hairvibe/views/forgot_pass_screen.dart';
import 'package:hairvibe/views/reset_password_screen.dart';
import 'package:hairvibe/views/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  AuthScreen.routeName: (context) => const AuthScreen(),
  ForgotPassScreen.routeName: (context) => const ForgotPassScreen(),
  ResetPasswordScreen.routeName: (context) => const ResetPasswordScreen(),
};
