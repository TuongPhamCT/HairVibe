import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairvibe/Models/service_model.dart';

class AppointmentModel {

  String? appointmentID;
  String? customerID;
  String? barberID;
  String? branchID;
  List<ServiceModel> services = [];
  DateTime? date;
  String? status;
  String? otherInfo;

  static String collectionName = 'Appointments';

  AppointmentModel(
    {
      required this.appointmentID,
      required this.customerID,
      required this.barberID,
      required this.branchID,
      required this.services,
      required this.date,
      required this.status,
      this.otherInfo
    }
  );

  Map<String, dynamic> toJson() => {
    'appointmentID': appointmentID,
    'customerID': customerID,
    'barberID': barberID,
    'branchID': branchID,
    'services': services.map((service) => service.toJson()).toList(),
    'date': Timestamp.fromDate(date!),
    'status': status,
    'otherInfo': otherInfo
  };

  static AppointmentModel fromJson(Map<String, dynamic> json) {
    final dataServices = json['services'] as List?;
    final listServices = List.castFrom<Object?, Map<String, Object?>>(dataServices!);
    return AppointmentModel(
      appointmentID: json['appointmentID'] as String,
      customerID: json['customerID'] as String,
      barberID: json['barberID'] as String,
      branchID: json['branchID'] as String,
      services: listServices.map((raw) => ServiceModel.fromJson(raw)).toList(),
      date: (json['date'] as Timestamp).toDate(),
      status: json['status'] as String,
      otherInfo: json['otherInfo'] as String
    );
  }
}