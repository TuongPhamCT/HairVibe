import 'package:hairvibe/Models/appointment_repo_impl.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:hairvibe/Models/appointment_model.dart';
import 'package:hairvibe/Utility.dart';

class MongoDBAppointmentRepoImpl implements AppointmentRepoImplInterface {
  final Db _db = Db(
      'mongodb://localhost:27017/hairvibe'); // Replace with your MongoDB connection string
 

  @override
  Future<void> addAppointment(AppointmentModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(AppointmentModel.collectionName);
      await collection.insertOne(model.toJson());
      print('Appointment added to MongoDB with ID: ${model.appointmentID}');
    } catch (e) {
      print('Error adding Appointment to MongoDB: $e');
    } finally {
      await _db.close();
    }
  }

  @override
  Future<bool> updateAppointment(AppointmentModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(AppointmentModel.collectionName);
      final result = await collection.updateOne(
        where.eq('appointmentID', model.appointmentID),
        modify.set('data', model.toJson()),
      );
      return result.isSuccess;
    } catch (e) {
      print('Error updating Appointment in MongoDB: $e');
      return false;
    } finally {
      await _db.close();
    }
  }

  @override
  Future<AppointmentModel?> getAppointmentById(String id) async {
    try {
      await _db.open();
      final collection = _db.collection(AppointmentModel.collectionName);
      final result = await collection.findOne(where.eq('appointmentID', id));
      return result != null ? AppointmentModel.fromJson(result) : null;
    } catch (e) {
      print(e);
      return null;
    } finally {
      await _db.close();
    }
  }

  @override
  Future<List<AppointmentModel>> getAllAppointments() async {
    try {
      await _db.open();
      final collection = _db.collection(AppointmentModel.collectionName);
      final results = await collection.find().toList();
      return results.map((json) => AppointmentModel.fromJson(json)).toList();
    } catch (e) {
      print(e);
      return [];
    } finally {
      await _db.close();
    }
  }

  Future<List<AppointmentModel>> _getAppointmentsByQuery(
      SelectorBuilder query) async {
    try {
      await _db.open();
      final collection = _db.collection(AppointmentModel.collectionName);
      final results = await collection.find(query).toList();
      return results.map((json) => AppointmentModel.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching Appointments by query: $e');
      return [];
    } finally {
      await _db.close();
    }
  }

  @override
  Future<List<AppointmentModel>> getAllCancelledAppointments(String id) =>
      _getAppointmentsByQuery(
          where.eq('status', AppointmentStatus.CANCELLED).eq('customerID', id));

  @override
  Future<List<AppointmentModel>> getAllCompletedAppointments(String id) =>
      _getAppointmentsByQuery(
          where.eq('status', AppointmentStatus.COMPLETED).eq('customerID', id));

  @override
  Future<List<AppointmentModel>> getAllUpcomingAppointments(String id) =>
      _getAppointmentsByQuery(
          where.eq('status', AppointmentStatus.UPCOMING).eq('customerID', id));

  @override
  Future<List<AppointmentModel>> getAppointmentsByUserId(String id) =>
      _getAppointmentsByQuery(where.eq('customerID', id));

  @override
  Future<List<AppointmentModel>> getAppointmentsByDate(DateTime date) async {
    final appointments = await getAllAppointments();
    return appointments
        .where((appointment) => Utility.isSameDate(appointment.date, date))
        .toList();
  }

  @override
  Future<List<AppointmentModel>> getActiveAppointmentsByDate(
      DateTime date) async {
    final appointments = await _getAppointmentsByQuery(where.oneFrom(
        'status', [AppointmentStatus.COMPLETED, AppointmentStatus.UPCOMING]));
    return appointments
        .where((appointment) => Utility.isSameDate(appointment.date, date))
        .toList();
  }

  @override
  Future<List<AppointmentModel>> getAppointmentsByUserIdAndDate(
      String id, DateTime date) async {
    final appointments =
        await _getAppointmentsByQuery(where.eq('customerID', id));
    return appointments
        .where((appointment) => Utility.isSameDate(appointment.date, date))
        .toList();
  }

  @override
  Future<List<AppointmentModel>> getAppointmentsByBarberIdAndDate(
      String id, DateTime date) async {
    final appointments =
        await _getAppointmentsByQuery(where.eq('barberID', id));
    return appointments
        .where((appointment) => Utility.isSameDate(appointment.date, date))
        .toList();
  }

  @override
  Future<List<AppointmentModel>> getActiveAppointmentsByBarberIdAndDate(
      String id, DateTime date) async {
    final appointments = await _getAppointmentsByQuery(where
        .eq('barberID', id)
        .oneFrom('status',
            [AppointmentStatus.COMPLETED, AppointmentStatus.UPCOMING]));
    return appointments
        .where((appointment) => Utility.isSameDate(appointment.date, date))
        .toList();
  }

  @override
  Future<List<AppointmentModel>> getCompletedAppointmentsByBarberIdAndDate(
      String id, DateTime date) async {
    final appointments = await _getAppointmentsByQuery(
        where.eq('barberID', id).eq('status', AppointmentStatus.COMPLETED));
    return appointments
        .where((appointment) => Utility.isSameDate(appointment.date, date))
        .toList();
  }

  @override
  Future<List<AppointmentModel>> getAppointmentsByBarberId(String id) =>
      _getAppointmentsByQuery(where.eq('barberID', id));

  @override
  Future<List<AppointmentModel>> getAppointmentsByUserIdAndBarberId(
          String userID, String barberID) =>
      _getAppointmentsByQuery(
          where.eq('userID', userID).eq('barberID', barberID));
}
