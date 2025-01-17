import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairvibe/Const/database_config.dart';
import 'package:hairvibe/Models/appointment_model.dart';
import 'package:hairvibe/Models/appointment_repo_impl.dart';
import 'package:hairvibe/Models/firebase/firebase_appointment_repo.dart';
import 'package:hairvibe/Models/mongoDB/mongoDB_appointment_repo_impl.dart';
import 'package:hairvibe/Utility.dart';

class AppointmentRepository {

  late AppointmentRepoImplInterface _impl;

  AppointmentRepository(String dbType) {
    switch (dbType) {
      case DatabaseConfig.FIREBASE:
        _impl = FirebaseAppointmentRepoImpl();
        break;
      case DatabaseConfig.MONGO_DB:
        _impl = MongoDBAppointmentRepoImpl();
    }
  }

  Future<void> addAppointment(AppointmentModel model) async {
    await _impl.addAppointment(model);
  }

  Future<bool> updateAppointment(AppointmentModel model) async {
    return await _impl.updateAppointment(model);
  }

  Future<AppointmentModel?> getAppointmentById(String id) async {
    return await _impl.getAppointmentById(id);
  }

  Future<List<AppointmentModel>> getAllAppointments() async {
    return await _impl.getAllAppointments();
  }

  Future<List<AppointmentModel>> getAllCancelledAppointments(String id) async {
    return await _impl.getAllCancelledAppointments(id);
  }

  Future<List<AppointmentModel>> getAllCompletedAppointments(String id) async {
    return await _impl.getAllCompletedAppointments(id);
  }

  Future<List<AppointmentModel>> getAllUpcomingAppointments(String id) async {
    return await _impl.getAllUpcomingAppointments(id);
  }

  Future<List<AppointmentModel>> getAppointmentsByUserId(String id) async {
    return await _impl.getAppointmentsByUserId(id);
  }

  Future<List<AppointmentModel>> getAppointmentsByDate(DateTime date) async {
    return await _impl.getAppointmentsByDate(date);
  }

  Future<List<AppointmentModel>> getActiveAppointmentsByDate(DateTime date) async {
    return await _impl.getActiveAppointmentsByDate(date);
  }

  Future<List<AppointmentModel>> getAppointmentsByUserIdAndDate(String id, DateTime date) async {
    return await _impl.getAppointmentsByUserIdAndDate(id, date);
  }

  Future<List<AppointmentModel>> getAppointmentsByBarberIdAndDate(String id, DateTime date) async {
    return await _impl.getAppointmentsByBarberIdAndDate(id, date);
  }

  Future<List<AppointmentModel>> getActiveAppointmentsByBarberIdAndDate(String id, DateTime date) async {
    return await _impl.getActiveAppointmentsByBarberIdAndDate(id, date);
  }

  Future<List<AppointmentModel>> getCompletedAppointmentsByBarberIdAndDate(String id, DateTime date) async {
    return await _impl.getCompletedAppointmentsByBarberIdAndDate(id, date);
  }

  Future<List<AppointmentModel>> getAppointmentsByBarberId(String id) async {
    return await _impl.getAppointmentsByBarberId(id);
  }

  Future<List<AppointmentModel>> getAppointmentsByUserIdAndBarberId(String userID, String barberID) async {
    return await _impl.getAppointmentsByUserIdAndBarberId(userID, barberID);
  }

  Future<String> generateAppointmentID(String barberID, String userID) async {
    List<AppointmentModel> appointments = await getAllAppointments();
    int count = appointments.length;
    return count.toString().padLeft(8, '0');
  }
}
