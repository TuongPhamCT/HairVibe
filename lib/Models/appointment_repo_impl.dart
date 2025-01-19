import 'package:hairvibe/Models/appointment_model.dart';

abstract class AppointmentRepoImplInterface {

  Future<void> addAppointment(AppointmentModel model);

  Future<bool> updateAppointment(AppointmentModel model);

  Future<AppointmentModel?> getAppointmentById(String id);

  Future<List<AppointmentModel>> getAllAppointments();

  Future<List<AppointmentModel>> getAllCancelledAppointments(String id);

  Future<List<AppointmentModel>> getAllCompletedAppointments(String id);

  Future<List<AppointmentModel>> getAllUpcomingAppointments(String id);

  Future<List<AppointmentModel>> getAppointmentsByUserId(String id);

  Future<List<AppointmentModel>> getAppointmentsByDate(DateTime date);

  Future<List<AppointmentModel>> getActiveAppointmentsByDate(DateTime date);

  Future<List<AppointmentModel>> getAppointmentsByUserIdAndDate(String id, DateTime date);

  Future<List<AppointmentModel>> getAppointmentsByBarberIdAndDate(String id, DateTime date);

  Future<List<AppointmentModel>> getActiveAppointmentsByBarberIdAndDate(String id, DateTime date);

  Future<List<AppointmentModel>> getCompletedAppointmentsByBarberIdAndDate(String id, DateTime date);

  Future<List<AppointmentModel>> getAppointmentsByBarberId(String id);

  Future<List<AppointmentModel>> getAppointmentsByUserIdAndBarberId(String userID, String barberID);
}
