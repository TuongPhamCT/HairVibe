import 'package:flutter/cupertino.dart';
import 'package:hairvibe/widgets/admin_bottom_bar.dart';
import 'package:hairvibe/widgets/barber_bottom_bar.dart';
import 'package:hairvibe/widgets/bottom_bar.dart';

abstract class BottomBarRenderStrategy {
  Widget render();
}

class CustomerBottomBarRenderStrategy implements BottomBarRenderStrategy {
  int index = 0;

  CustomerBottomBarRenderStrategy({
    required this.index,
  });

  @override
  Widget render() {
    return BottomBarCustom(currentIndex: index);
  }
}

class AdminBottomBarRenderStrategy implements BottomBarRenderStrategy {
  int index = 0;

  AdminBottomBarRenderStrategy({
    required this.index,
  });

  @override
  Widget render() {
    return AdminBottomBar(currentIndex: index);
  }
}

class BarberBottomBarRenderStrategy implements BottomBarRenderStrategy {
  int index = 0;

  BarberBottomBarRenderStrategy({
    required this.index,
  });

  @override
  Widget render() {
    return BarberBottomNavigationBar(currentIndex: index);
  }
}