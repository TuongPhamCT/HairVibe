import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hairvibe/views/no_network.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      if (Get.currentRoute != NoNetworkScreen.routeName) {
        Navigator.of(Get.context!).pushNamed(NoNetworkScreen.routeName);
      }
    } else {
      if (Get.currentRoute == NoNetworkScreen.routeName) {
        Get.back();
      }
    }
  }
}
