import 'package:hairvibe/Builders/ModelBuilder/appointment_model_builder.dart';
import 'package:hairvibe/Facades/notification_facade.dart';
import 'package:hairvibe/Models/appointment_repo.dart';
import 'package:hairvibe/Models/coupon_model.dart';
import 'package:hairvibe/Models/service_model.dart';
import 'package:hairvibe/Models/user_model.dart';
import 'package:hairvibe/Singletons/user_singleton.dart';

import '../Models/appointment_model.dart';

class BookingSingleton {
  static BookingSingleton? _instance;

  static BookingSingleton getInstance() {
    _instance ??= BookingSingleton();
    return _instance!;
  }

  final AppointmentModelBuilder builder = AppointmentModelBuilder();
  final AppointmentRepository _appointmentRepo = AppointmentRepository();

  String? customerID;
  String? barberID;

  CouponModel? usedCoupon;
  // Use when user navigate from Voucher Page
  CouponModel? cacheCoupon;

  ServiceModel? cacheService;
  UserModel? cacheBarber;

  void setCustomerID(String customerID) {
    this.customerID = customerID;
  }

  void setBarberID(String barberID) {
    this.barberID = barberID;
  }

  void setCoupon(CouponModel coupon) {
    usedCoupon = coupon;
  }

  void setCacheCoupon(CouponModel coupon) {
    cacheCoupon = coupon;
  }

  void setCacheBarber(UserModel barber) {
    cacheBarber = barber;
  }

  void setCacheService(ServiceModel service) {
    cacheService = service;
  }

  void resetCache() {
    cacheService = null;
    cacheCoupon = null;
    cacheBarber = null;
  }

  void reset() {
    builder.reset();
    customerID = null;
    barberID = null;
    usedCoupon = null;
  }

  Future<bool> confirmAppointment() async {
    NotificationFacade notificationFacade = NotificationFacade();

    if (customerID == null || barberID == null ) {
      return false;
    }

    builder.setAppointmentID(await _appointmentRepo.generateAppointmentID(barberID!, customerID!));
    if (usedCoupon != null) {
      builder.setDiscount(usedCoupon!.discountRate!);
    }

    AppointmentModel appointment = builder.build();

    await _appointmentRepo.addAppointmentToFirestore(appointment);
    await notificationFacade.createBookingAppointmentNotification(
        appointment: appointment,
        customerName: UserSingleton.getInstance().currentUser!.name!
    );
    return true;
  }
}