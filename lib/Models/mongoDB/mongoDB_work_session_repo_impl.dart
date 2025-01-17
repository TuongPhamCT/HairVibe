import 'package:mongo_dart/mongo_dart.dart';
import 'package:hairvibe/Models/work_session_model.dart';
import 'package:hairvibe/Models/work_session_repo_impl.dart';

class MongoDBWorkSessionRepoImpl implements WorkSessionRepoImplInterface {
  final Db _db = Db(
      'mongodb://localhost:27017/hairvibe'); // Replace with your MongoDB connection string

  @override
  Future<String> addWorkSession(WorkSessionModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(WorkSessionModel.collectionName);
      final result = await collection.insert(model.toJson());
      final sessionId = result['insertedId'].toString();
      print('WorkSession added to MongoDB with ID: $sessionId');
      return sessionId;
    } catch (e) {
      print('Error adding WorkSession to MongoDB: $e');
      return "";
    } finally {
      await _db.close();
    }
  }

  @override
  Future<void> deleteWorkSessionById(String userId, String id) async {
    try {
      await _db.open();
      final collection = _db.collection(WorkSessionModel.collectionName);
      await collection
          .remove(where.eq('barberID', userId).eq('_id', ObjectId.parse(id)));
      print('WorkSession deleted from MongoDB with ID: $id');
    } catch (e) {
      print('Error deleting WorkSession from MongoDB: $e');
    } finally {
      await _db.close();
    }
  }

  @override
  Future<List<WorkSessionModel>> getWorkSessionsByBarberId(String id) async {
    try {
      await _db.open();
      final collection = _db.collection(WorkSessionModel.collectionName);
      final results = await collection.find(where.eq('barberID', id)).toList();
      return results
          .map((json) => WorkSessionModel.fromJson(json['_id'], json))
          .toList();
    } catch (e) {
      print('Error fetching WorkSessions from MongoDB: $e');
      return [];
    } finally {
      await _db.close();
    }
  }
}
