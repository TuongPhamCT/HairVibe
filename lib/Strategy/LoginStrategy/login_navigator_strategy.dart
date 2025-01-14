import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hairvibe/views/admin/admin_home_screen.dart';
import '../../views/home/home_screen.dart';

abstract class LoginNavigatorStrategy {
  void execute(BuildContext context);
}

class CustomerLoginNavigatorStrategy implements LoginNavigatorStrategy {
  @override
  void execute(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }
}

class AdminLoginNavigatorStrategy implements LoginNavigatorStrategy {
  @override
  void execute(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AdminHomeScreen()),
    );
  }
}

class BarberLoginNavigatorStrategy implements LoginNavigatorStrategy {
  @override
  void execute(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AdminHomeScreen()),
    );
  }
}