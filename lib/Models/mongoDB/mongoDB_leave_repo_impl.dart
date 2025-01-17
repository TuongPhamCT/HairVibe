import 'package:mongo_dart/mongo_dart.dart';
import 'package:hairvibe/Models/leave_model.dart';
import 'package:hairvibe/Models/leave_repo_impl.dart';

class MongoDBLeaveRepoImpl implements LeaveRepoImplInterface {
  final Db _db = Db(
      'mongodb://localhost:27017/hairvibe'); // Replace with your MongoDB connection string

  @override
  Future<void> addLeave(LeaveModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(LeaveModel.collectionName);
      await collection.insert(model.toJson());
      print('Leave added to MongoDB with ID: ${model.leaveID}');
    } catch (e) {
      print('Error adding Leave to MongoDB: $e');
    } finally {
      await _db.close();
    }
  }

  @override
  Future<List<LeaveModel>> getLeavesByBarberId(String id) async {
    try {
      await _db.open();
      final collection = _db.collection(LeaveModel.collectionName);
      final results = await collection.find(where.eq('barberID', id)).toList();
      return results.map((json) => LeaveModel.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching Leaves by Barber ID from MongoDB: $e');
      return [];
    } finally {
      await _db.close();
    }
  }

  @override
  Future<bool> updateLeave(LeaveModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(LeaveModel.collectionName);
      final result = await collection.update(
        where.eq('leaveID', model.leaveID),
        model.toJson(),
      );
      return result['n'] > 0; // Check if any document was updated
    } catch (e) {
      print('Error updating Leave in MongoDB: $e');
      return false;
    } finally {
      await _db.close();
    }
  }
}
