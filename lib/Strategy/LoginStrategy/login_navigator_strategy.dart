import 'package:flutter/cupertino.dart';
import 'package:hairvibe/views/admin/home_screen.dart';

import '../../views/barber/home_screen.dart';
import '../../views/home/home_screen.dart';

abstract class LoginNavigatorStrategy {
  void execute(BuildContext context);
}

class CustomerLoginNavigatorStrategy implements LoginNavigatorStrategy {
  @override
  void execute(BuildContext context) {
    Navigator.of(context).pushNamed(HomeScreen.routeName);
  }
}

class AdminLoginNavigatorStrategy implements LoginNavigatorStrategy {
  @override
  void execute(BuildContext context) {
    Navigator.of(context).pushNamed(AdminHomeScreen.routeName);
  }
}

class BarberLoginNavigatorStrategy implements LoginNavigatorStrategy {
  @override
  void execute(BuildContext context) {
    Navigator.of(context).pushNamed(BarberHomeScreen.routeName);
  }
}