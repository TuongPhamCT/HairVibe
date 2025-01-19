import 'package:mongo_dart/mongo_dart.dart';
import 'package:hairvibe/Models/service_model.dart';
import '../service_repo_impl.dart';

class MongoDBServiceRepoImpl implements ServiceRepoImplInterface {
  final Db _db = Db(
      'mongodb://localhost:27017/hairvibe'); // Replace with your MongoDB connection string

  @override
  Future<String> addService(ServiceModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(ServiceModel.collectionName);
      final result = await collection.insert(model.toJson());
      final serviceId = result['insertedId'].toString();
      print('Service added to MongoDB with ID: $serviceId');
      return serviceId;
    } catch (e) {
      print('Error adding Service to MongoDB: $e');
      return "";
    } finally {
      await _db.close();
    }
  }

  @override
  Future<bool> updateService(ServiceModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(ServiceModel.collectionName);
      final result = await collection.update(
        where.eq('serviceID', model.serviceID),
        model.toJson(),
      );
      return result['n'] > 0; // Check if any document was updated
    } catch (e) {
      print('Error updating Service in MongoDB: $e');
      return false;
    } finally {
      await _db.close();
    }
  }

  @override
  Future<void> deleteServiceById(String id) async {
    try {
      await _db.open();
      final collection = _db.collection(ServiceModel.collectionName);
      await collection.remove(where.eq('serviceID', id));
      print('Service deleted from MongoDB with ID: $id');
    } catch (e) {
      print('Error deleting Service from MongoDB: $e');
    } finally {
      await _db.close();
    }
  }

  @override
  Future<List<ServiceModel>> getAllServices() async {
    try {
      await _db.open();
      final collection = _db.collection(ServiceModel.collectionName);
      final results = await collection.find().toList();
      return results
          .map((json) => ServiceModel.fromJson(json['_id'], json))
          .toList();
    } catch (e) {
      print('Error fetching all Services from MongoDB: $e');
      return [];
    } finally {
      await _db.close();
    }
  }
}
