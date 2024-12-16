import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairvibe/Models/service_model.dart';

class AppointmentModel {

  String? appointmentID;
  String? customerID;
  String? barberID;
  List<ServiceModel>? services = [];
  DateTime? date;
  String? status;
  Map<String, Object?>? otherInfo = {};

  static String collectionName = 'Appointments';

  AppointmentModel(
    {
      this.appointmentID,
      this.customerID,
      this.barberID,
      this.services,
      this.date,
      this.status,
      this.otherInfo
    }
  );

  Map<String, dynamic> toJson() => {
    'appointmentID': appointmentID,
    'customerID': customerID,
    'barberID': barberID,
    'services': services?.map((service) => service.toJson()).toList(),
    'date': Timestamp.fromDate(date!),
    'status': status,
    'otherInfo': otherInfo
  };

  static AppointmentModel fromJson(Map<String, dynamic> json) {
    final dataServices = json['services'] as List?;
    final listServices = List.castFrom<Object?, Map<String, Object?>>(dataServices!);
    final dataOtherInfo = json['otherInfo'] as Map<String, Object?>?;
    return AppointmentModel(
      appointmentID: json['appointmentID'] as String,
      customerID: json['customerID'] as String,
      barberID: json['barberID'] as String,
      services: listServices.map((raw) => ServiceModel.fromJson(raw)).toList(),
      date: (json['date'] as Timestamp).toDate(),
      status: json['status'] as String,
      otherInfo: dataOtherInfo
    );
  }
}

abstract class AppointmentStatus {
  static const String CANCELLED = "cancelled";
  static const String COMPLETED = "completed";
  static const String UPCOMING = "upcoming";
}

abstract class AppointmentOtherInfo {
  static const String DISCOUNT = "discount";
  static const String CANCEL_REASON = "cancelReason";
}