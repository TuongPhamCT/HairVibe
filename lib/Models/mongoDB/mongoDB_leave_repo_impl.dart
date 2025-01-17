import 'package:mongo_dart/mongo_dart.dart';
import 'package:hairvibe/Models/leave_model.dart';

class MongoDBLeaveRepoImplementation {
  final Db _db = Db(
      'mongodb://localhost:27017/hairvibe'); // Replace with your MongoDB connection string
  final String collectionName = LeaveModel.collectionName;

  Future<void> addLeaveToMongo(LeaveModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      await collection.insertOne(model.toJson());
      print('Leave added to MongoDB with ID: ${model.leaveID}');
    } catch (e) {
      print('Error adding Leave to MongoDB: $e');
    } finally {
      await _db.close();
    }
  }

  Future<List<LeaveModel>> getLeavesByBarberId(String id) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      final results = await collection.find(where.eq('barberID', id)).toList();
      return results.map((json) => LeaveModel.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching Leaves by Barber ID from MongoDB: $e');
      return [];
    } finally {
      await _db.close();
    }
  }

  Future<bool> updateLeave(LeaveModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      final result = await collection.updateOne(
        where.eq('leaveID', model.leaveID),
        modify.set('data', model.toJson()),
      );
      return result.isSuccess;
    } catch (e) {
      print('Error updating Leave in MongoDB: $e');
      return false;
    } finally {
      await _db.close();
    }
  }
}
