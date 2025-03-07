import 'package:hairvibe/Models/service_model.dart';

import '../../Models/appointment_model.dart';

class AppointmentModelBuilder {
  AppointmentModel _model = AppointmentModel();

  AppointmentModelBuilder();

  void setAppointment(AppointmentModel appointment) {
    _model = appointment;
  }

  void setAppointmentID(String id) {
    _model.appointmentID = id;
  }

  void setCustomerID(String id) {
    _model.customerID = id;
  }

  void setBarberID(String id) {
    _model.barberID = id;
  }

  void setDate(DateTime date) {
    _model.date = date;
  }

  void setStatus(String status) {
    _model.status = status;
  }

  void setDiscount(int percent) {
    _model.otherInfo?[AppointmentOtherInfo.DISCOUNT] = percent;
  }

  void setCancelReason(String reason) {
    _model.otherInfo?[AppointmentOtherInfo.CANCEL_REASON] = reason;
  }

  void setServices(List<ServiceModel> services) {
    _model.services = services;
  }

  void addService(ServiceModel service) {
    _model.services!.add(service);
  }

  void addServices(List<ServiceModel> services) {
    _model.services ??= [];
    _model.services!.addAll(services);
  }

  AppointmentModel build() {
    return _model;
  }

  void reset() {
    _model = AppointmentModel();
  }
}