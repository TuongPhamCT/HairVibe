import 'package:hairvibe/Models/appointment_repo_impl.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:hairvibe/Models/appointment_model.dart';
import 'package:hairvibe/Utility.dart';

class MongoDBAppointmentRepoImplementation implements AppointmentRepoImplInterface {
  final Db _db = Db(
      'mongodb://localhost:27017/hairvibe'); // Replace with your MongoDB connection string
  final String collectionName = AppointmentModel.collectionName;

  Future<void> addAppointmentToMongo(AppointmentModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
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
      final collection = _db.collection(collectionName);
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
      final collection = _db.collection(collectionName);
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
      final collection = _db.collection(collectionName);
      final results = await collection.find().toList();
      return results.map((json) => AppointmentModel.fromJson(json)).toList();
    } catch (e) {
      print(e);
      return [];
    } finally {
      await _db.close();
    }
  }

  Future<List<AppointmentModel>> getAppointmentsByField(
      String field, dynamic value) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      final results = await collection.find(where.eq(field, value)).toList();
      return results.map((json) => AppointmentModel.fromJson(json)).toList();
    } catch (e) {
      print(e);
      return [];
    } finally {
      await _db.close();
    }
  }

  @override
  Future<List<AppointmentModel>> getAppointmentsByDate(DateTime date) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      final results = await collection.find().toList();
      return results
          .map((json) => AppointmentModel.fromJson(json))
          .where((appointment) => Utility.isSameDate(appointment.date, date))
          .toList();
    } catch (e) {
      print(e);
      return [];
    } finally {
      await _db.close();
    }
  }

  Future<List<AppointmentModel>> getActiveAppointmentsByDate(
      DateTime date) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      final results = await collection
          .find(
            where.oneFrom('status',
                [AppointmentStatus.COMPLETED, AppointmentStatus.UPCOMING]),
          )
          .toList();
      return results
          .map((json) => AppointmentModel.fromJson(json))
          .where((appointment) => Utility.isSameDate(appointment.date, date))
          .toList();
    } catch (e) {
      print(e);
      return [];
    } finally {
      await _db.close();
    }
  }

  Future<String> generateAppointmentID() async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      final count = await collection.count();
      return count.toString().padLeft(8, '0');
    } catch (e) {
      print(e);
      return '00000000';
    } finally {
      await _db.close();
    }
  }
}
