import 'package:flutter/cupertino.dart';
import 'package:hairvibe/Strategy/BottomBarStrategy/bottom_bar_strategy.dart';

import '../Models/user_model.dart';
import 'notification_singleton.dart';

class UserSingleton {
  static UserSingleton? _instance;

  static UserSingleton getInstance() {
    _instance ??= UserSingleton();
    return _instance!;
  }

  UserModel? currentUser;

  bool currentUserIsCustomer() {
    return currentUser != null
        && currentUser!.userType == UserType.CUSTOMER;
  }

  bool currentUserIsBarber() {
    return currentUser != null
        && currentUser!.userType == UserType.BARBER;
  }

  bool currentUserIsAdmin() {
    return currentUser != null
        && currentUser!.userType == UserType.ADMIN;
  }

  void setCurrentUser(UserModel model) {
    currentUser = model;
  }

  Future<void> handleActionsAfterLogin() async {
    NotificationSingleton singleton = NotificationSingleton.getInstance();
    singleton.initialize();
  }

  Future<void> handleActionsAfterLogOut() async {
    NotificationSingleton singleton = NotificationSingleton.getInstance();
    singleton.dispose();
  }

  BottomBarRenderStrategy? getBottomBarRenderStrategy(int index) {
    if (currentUser == null) {
      return CustomerBottomBarRenderStrategy(index: 0);
    }

    switch (currentUser!.userType!) {
      case UserType.CUSTOMER:
        return CustomerBottomBarRenderStrategy(index: index);
      case UserType.BARBER:
        return BarberBottomBarRenderStrategy(index: index);
      case UserType.ADMIN:
        return AdminBottomBarRenderStrategy(index: index);
      default:
        return CustomerBottomBarRenderStrategy(index: index);
    }
  }
}