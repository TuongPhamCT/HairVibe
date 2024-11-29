import 'package:flutter/material.dart';
import 'package:hairvibe/views/all_barber/barber.dart';
import 'package:hairvibe/views/all_service.dart';
import 'package:hairvibe/views/appoinment/appointment.dart';
import 'package:hairvibe/views/auth_screen.dart';
import 'package:hairvibe/views/forgot_pass_screen.dart';
import 'package:hairvibe/views/home/home_screen.dart';
import 'package:hairvibe/views/no_network.dart';
import 'package:hairvibe/views/reset_password_screen.dart';
import 'package:hairvibe/views/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  AuthScreen.routeName: (context) => const AuthScreen(),
  ForgotPassScreen.routeName: (context) => const ForgotPassScreen(),
  ResetPasswordScreen.routeName: (context) => const ResetPasswordScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  AppointmentScreen.routeName: (context) => const AppointmentScreen(),
  AllServiceScreen.routeName: (context) => const AllServiceScreen(),
  BarberScreen.routeName: (context) => const BarberScreen(),
  NoNetworkScreen.routeName: (context) => const NoNetworkScreen(),
};
