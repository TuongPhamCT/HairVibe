import 'package:mongo_dart/mongo_dart.dart';
import 'package:hairvibe/Models/service_model.dart';

class MongoDBServiceRepoImplementation {
  final Db _db = Db(
      'mongodb://localhost:27017/hairvibe'); // Replace with your MongoDB connection string
  final String collectionName = ServiceModel.collectionName;

  Future<String> addServiceToMongo(ServiceModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      final result = await collection.insertOne(model.toJson());
      final insertedId = result['insertedId'];
      print('Service added to MongoDB with ID: $insertedId');
      return insertedId.toString();
    } catch (e) {
      print('Error adding Service to MongoDB: $e');
      return "";
    } finally {
      await _db.close();
    }
  }

  Future<bool> updateService(ServiceModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      final result = await collection.updateOne(
        where.eq('_id', model.serviceID),
        modify.set('data', model.toJson()),
      );
      return result.isSuccess;
    } catch (e) {
      print('Error updating Service in MongoDB: $e');
      return false;
    } finally {
      await _db.close();
    }
  }

  Future<void> deleteServiceById(String id) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      await collection.deleteOne(where.eq('_id', id));
      print('Service with ID: $id deleted from MongoDB.');
    } catch (e) {
      print('Error deleting Service from MongoDB: $e');
    } finally {
      await _db.close();
    }
  }

  Future<List<ServiceModel>> getAllServices() async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      final results = await collection.find().toList();
      return results
          .map((json) => ServiceModel.fromJson(json['_id'].toString(), json))
          .toList();
    } catch (e) {
      print('Error fetching all Services from MongoDB: $e');
      return [];
    } finally {
      await _db.close();
    }
  }

  Future<int> getServicesCount() async {
    try {
      final services = await getAllServices();
      return services.length;
    } catch (e) {
      print('Error fetching Service count from MongoDB: $e');
      return 0;
    }
  }
}
