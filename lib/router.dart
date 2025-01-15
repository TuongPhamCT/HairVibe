import 'package:flutter/material.dart';
import 'package:hairvibe/views/account/about_us.dart';
import 'package:hairvibe/views/account/account_page.dart';
import 'package:hairvibe/views/account/edit_account.dart';
import 'package:hairvibe/views/admin_appointment/appointment_details.dart';
import 'package:hairvibe/views/admin_management/add_service.dart';
import 'package:hairvibe/views/all_barber/barber.dart';
import 'package:hairvibe/views/all_barber/detail_barber.dart';
import 'package:hairvibe/views/all_barber/rating_barber.dart';
import 'package:hairvibe/views/all_service.dart';
import 'package:hairvibe/views/appoinment/appointment.dart';
import 'package:hairvibe/views/appoinment/cancel_appointment.dart';
import 'package:hairvibe/views/auth_screen.dart';
import 'package:hairvibe/views/booking/confirm_booking.dart';
import 'package:hairvibe/views/booking/main_booking.dart';
import 'package:hairvibe/views/booking/success_booking.dart';
import 'package:hairvibe/views/booking/view_booking.dart';
import 'package:hairvibe/views/booking/voucher_redeem.dart';
import 'package:hairvibe/views/forgot_pass_screen.dart';
import 'package:hairvibe/views/home/home_screen.dart';
import 'package:hairvibe/views/no_network.dart';
import 'package:hairvibe/views/notification/notification_page.dart';
import 'package:hairvibe/views/reset_password_screen.dart';
import 'package:hairvibe/views/splash_screen.dart';
import 'package:hairvibe/views/voucher/redeem_voucher.dart';
import 'package:hairvibe/views/voucher/voucher_page.dart';

import 'package:hairvibe/views/admin/admin_home_screen.dart';
import 'package:hairvibe/views/admin_appointment/appointment_calendar.dart';
import 'package:hairvibe/views/admin_contact/contact_list.dart';
import 'package:hairvibe/views/admin_management/comment.dart';

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
  SuccessBooking.routeName: (context) => const SuccessBooking(),
  ViewBooking.routeName: (context) => const ViewBooking(),
  VoucherRedeem.routeName: (context) => const VoucherRedeem(),

  //Barber
  DetailBarber.routeName: (context) => const DetailBarber(),

  // Cancel Appointment
  CancelAppointmentPage.routeName: (context) => const CancelAppointmentPage(),
  RatingBarberPage.routeName: (context) => const RatingBarberPage(),

  VoucherPage.routeName: (context) => const VoucherPage(),
  AccountPage.routeName: (context) => const AccountPage(),
  RedeemVoucher.routeName: (context) => const RedeemVoucher(),
  AboutUs.routeName: (context) => const AboutUs(),
  EditAccount.routeName: (context) => const EditAccount(),

  NotificationsPage.routeName: (context) => const NotificationsPage(),

  // Admin
  AdminHomeScreen.routeName: (context) => const AdminHomeScreen(),
  AdminAppointmentPage.routeName: (context) => const AdminAppointmentPage(),
  AdminContactListPage.routeName: (context) => const AdminContactListPage(),
  AdminCommentPage.routeName: (context) => const AdminCommentPage(),
  AddServicePage.routeName: (context) => const AddServicePage(),
  AdminAppointmentDetailPage.routeName: (context) => const AdminAppointmentDetailPage(),
};
