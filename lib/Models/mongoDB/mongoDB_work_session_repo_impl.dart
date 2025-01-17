import 'package:mongo_dart/mongo_dart.dart';
import 'package:hairvibe/Models/work_session_model.dart';

class MongoDBWorkSessionRepoImplementation {
  final Db _db = Db(
      'mongodb://localhost:27017/hairvibe'); // Replace with your MongoDB connection string
  final String collectionName = WorkSessionModel.collectionName;

  Future<String> addWorkSessionToMongo(WorkSessionModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      final result = await collection.insertOne(model.toJson());
      final insertedId = result['insertedId'];
      print('WorkSession added to MongoDB with ID: $insertedId');
      return insertedId.toString();
    } catch (e) {
      print('Error adding WorkSession to MongoDB: $e');
      return "";
    } finally {
      await _db.close();
    }
  }

  Future<void> deleteWorkSessionById(String id) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      await collection.deleteOne(where.eq('_id', id));
      print('WorkSession with ID: $id deleted from MongoDB.');
    } catch (e) {
      print('Error deleting WorkSession from MongoDB: $e');
    } finally {
      await _db.close();
    }
  }

  Future<List<WorkSessionModel>> getWorkSessionsByBarberId(
      String barberId) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      final results =
          await collection.find(where.eq('barberID', barberId)).toList();
      return results
          .map(
              (json) => WorkSessionModel.fromJson(json['_id'].toString(), json))
          .toList();
    } catch (e) {
      print('Error fetching WorkSessions by Barber ID from MongoDB: $e');
      return [];
    } finally {
      await _db.close();
    }
  }
}
