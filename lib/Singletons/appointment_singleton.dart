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

  void reset() {
    appointment = null;
    cacheData.clear();
  }

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
    data[ViewBookingData.CUSTOMER_AVATAR] = customer.image;

    int sum = 0;
    for (ServiceModel service in appointment!.services!) {
      sum += service.price ?? 0;
    }

    if (appointment!.otherInfo != null) {
      Map<String, Object?> otherInfo = appointment!.otherInfo!;
      if (otherInfo.containsKey(AppointmentOtherInfo.DISCOUNT)) {
        data[ViewBookingData.DISCOUNT] = otherInfo[AppointmentOtherInfo.DISCOUNT] as int;
      } else {
        data[ViewBookingData.DISCOUNT] = 0;
      }
    }

    data[ViewBookingData.TOTAL_PRICE]
      = (sum * ( 100 - (data[ViewBookingData.DISCOUNT] ?? 0 ))) ~/ 100;

    cacheData = data;
  }

  Map<String, dynamic> getViewBookingData() {
    return cacheData;
  }

  String getCustomerName() {
    if (cacheData.containsKey(ViewBookingData.NAME)) {
      return cacheData[ViewBookingData.NAME];
    }
    return "Customer Name";
  }

  String getCustomerAvatarUrl() {
    if (cacheData.containsKey(ViewBookingData.CUSTOMER_AVATAR)) {
      return cacheData[ViewBookingData.CUSTOMER_AVATAR];
    }
    return "";
  }

  String getAppointmentDate() {
    if (cacheData.containsKey(ViewBookingData.BOOKING_DATE)) {
      return cacheData[ViewBookingData.BOOKING_DATE];
    }
    return "dd/mm/yyyy";
  }

  String getAppointmentTime() {
    if (cacheData.containsKey(ViewBookingData.BOOKING_TIME)) {
      return cacheData[ViewBookingData.BOOKING_TIME];
    }
    return "dd/mm/yyyy";
  }

  List<ServiceModel> getServices() {
    if (cacheData.containsKey(ViewBookingData.SERVICES)) {
      return cacheData[ViewBookingData.SERVICES];
    }
    return [];
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
  static const CUSTOMER_AVATAR = "customerAvatarUrl";
}