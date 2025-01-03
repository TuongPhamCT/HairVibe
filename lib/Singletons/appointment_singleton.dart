import 'package:hairvibe/Facades/authenticator_facade.dart';
import 'package:hairvibe/Models/appointment_model.dart';
import 'package:hairvibe/Models/user_repo.dart';
import 'package:hairvibe/Utility.dart';

import '../Models/service_model.dart';
import '../Models/user_model.dart';

class AppointmentSingleton {
  static AppointmentSingleton? _instance;
  static AppointmentSingleton getInstance() {
    _instance ??= AppointmentSingleton();
    return _instance!;
  }

  AppointmentSingleton();

  AppointmentModel? appointment;

  final UserRepository _userRepo = UserRepository();
  final AuthenticatorFacade _auth = AuthenticatorFacade();

  Map<String, dynamic> cacheData = {};

  void setAppointment(AppointmentModel appointment) {
    this.appointment = appointment;
  }

  void setDiscount(int discount) {
    if (cacheData.containsKey(ViewBookingData.DISCOUNT)) {
      cacheData[ViewBookingData.DISCOUNT] = discount as String;
    }
  }

  Future<void> loadViewBookingData() async {
    if (appointment == null) {
      cacheData = {};
    }

    UserModel customer = await _userRepo.getUserById(_auth.userId!);
    UserModel barber = await _userRepo.getUserById(appointment!.barberID!);

    Map<String, dynamic> data = {};

    data[ViewBookingData.NAME] = customer.name;
    data[ViewBookingData.PHONE] = customer.phoneNumber;
    data[ViewBookingData.BOOKING_DATE] = Utility.formatDateFromDateTime(appointment!.date);
    data[ViewBookingData.BOOKING_TIME] = Utility.formatTimeFromDateTime(appointment!.date);
    data[ViewBookingData.SERVICES] = appointment!.services;
    data[ViewBookingData.BARBER] = barber.name;

    int sum = 0;
    for (ServiceModel service in appointment!.services!) {
      sum += service.price ?? 0;
    }

    if (appointment!.otherInfo != null) {
      Map<String, Object?> otherInfo = appointment!.otherInfo!;
      if (otherInfo.containsKey(AppointmentOtherInfo.DISCOUNT)) {
        data[ViewBookingData.DISCOUNT] = otherInfo[AppointmentOtherInfo.DISCOUNT] as String;
      } else {
        data[ViewBookingData.DISCOUNT] = "0";
      }
    }

    data[ViewBookingData.TOTAL_PRICE] = sum * data[ViewBookingData.DISCOUNT] / 100;

    cacheData = data;
  }

  Map<String, dynamic> getViewBookingData() {
    return cacheData;
  }
}

abstract class ViewBookingData {
  static const NAME = "name";
  static const PHONE = "phone";
  static const BOOKING_DATE = "bookingDate";
  static const BOOKING_TIME = "bookingTime";
  static const BARBER = "barber";
  static const SERVICES = "services";
  static const TOTAL_PRICE = "totalPrices";
  static const DISCOUNT = "discount";
}