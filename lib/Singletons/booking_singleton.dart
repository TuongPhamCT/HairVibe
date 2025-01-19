import 'package:hairvibe/Builders/ModelBuilder/appointment_model_builder.dart';
import 'package:hairvibe/Const/app_config.dart';
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
  final AppointmentRepository _appointmentRepo = AppointmentRepository(AppConfig.dbType);

  String? customerID;
  String? barberID;

  CouponModel? usedCoupon;
  // Use when user navigate from Voucher Page
  CouponModel? selectedCoupon;

  ServiceModel? selectedService;
  UserModel? selectedBarber;

  void setCustomerID(String customerID) {
    this.customerID = customerID;
  }

  void setBarberID(String barberID) {
    this.barberID = barberID;
  }

  void setCoupon(CouponModel coupon) {
    usedCoupon = coupon;
  }

  void setSelectedCoupon(CouponModel coupon) {
    selectedCoupon = coupon;
  }

  void setSelectedBarber(UserModel barber) {
    selectedBarber = barber;
  }

  void setSelectedService(ServiceModel service) {
    selectedService = service;
  }

  void resetCache() {
    selectedService = null;
    selectedCoupon = null;
    selectedBarber = null;
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

    await _appointmentRepo.addAppointment(appointment);
    await notificationFacade.createBookingAppointmentNotification(
        appointment: appointment,
        customerName: UserSingleton.getInstance().currentUser!.name!
    );
    return true;
  }
}