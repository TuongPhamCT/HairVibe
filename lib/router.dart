import 'package:flutter/material.dart';
import 'package:hairvibe/views/all_barber/barber.dart';
import 'package:hairvibe/views/all_barber/detail_barber.dart';
import 'package:hairvibe/views/all_barber/rating_barber.dart';
import 'package:hairvibe/views/all_service.dart';
import 'package:hairvibe/views/appoinment/appointment.dart';
import 'package:hairvibe/views/appoinment/cancel_appointment.dart';
import 'package:hairvibe/views/auth_screen.dart';
import 'package:hairvibe/views/booking/confirm_booking.dart';
import 'package:hairvibe/views/booking/main_booking.dart';
import 'package:hairvibe/views/booking/sucess_booking.dart';
import 'package:hairvibe/views/booking/view_booking.dart';
import 'package:hairvibe/views/booking/voucher_redeem.dart';
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

  // Booking
  MainBooking.routeName: (context) => const MainBooking(),
  ConfirmBooking.routeName: (context) => const ConfirmBooking(),
  SucessBooking.routeName: (context) => const SucessBooking(),
  ViewBooking.routeName: (context) => const ViewBooking(),
  VoucherRedeem.routeName: (context) => const VoucherRedeem(),

  //Barber
  DetailBarber.routeName: (context) => const DetailBarber(),

  // Cancel Appointment
  CancelAppointmentPage.routeName: (context) => const CancelAppointmentPage(),
  RatingBarberPage.routeName: (context) => const RatingBarberPage(),
};
