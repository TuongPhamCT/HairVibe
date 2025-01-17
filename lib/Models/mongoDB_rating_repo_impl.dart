import 'package:mongo_dart/mongo_dart.dart';
import 'package:hairvibe/Models/rating_model.dart';

class MongoDBRatingRepoImplementation {
  final Db _db = Db(
      'mongodb://localhost:27017/hairvibe'); // Replace with your MongoDB connection string
  final String collectionName = RatingModel.collectionName;

  Future<String> addRatingToMongo(RatingModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      final result = await collection.insertOne(model.toJson());
      print('Rating added to MongoDB with ID: ${result['insertedId']}');
      return result['insertedId'].toString();
    } catch (e) {
      print('Error adding Rating to MongoDB: $e');
      return "";
    } finally {
      await _db.close();
    }
  }

  Future<void> deleteRatingById(String ratingId) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      await collection.deleteOne(where.eq('_id', ratingId));
      print('Rating with ID: $ratingId deleted from MongoDB.');
    } catch (e) {
      print('Error deleting Rating from MongoDB: $e');
    } finally {
      await _db.close();
    }
  }

  Future<bool> updateRating(RatingModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      final result = await collection.updateOne(
        where.eq('_id', model.ratingID),
        modify.set('data', model.toJson()),
      );
      return result.isSuccess;
    } catch (e) {
      print('Error updating Rating in MongoDB: $e');
      return false;
    } finally {
      await _db.close();
    }
  }

  Future<List<RatingModel>> getRatingsByBarberId(String barberId) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      final results =
          await collection.find(where.eq('barberID', barberId)).toList();
      return results.map((json) => RatingModel.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching Ratings by Barber ID from MongoDB: $e');
      return [];
    } finally {
      await _db.close();
    }
  }

  Future<double> calculateRatingOfBarber(String barberId) async {
    try {
      List<RatingModel> list = await getRatingsByBarberId(barberId);
      if (list.isEmpty) {
        return 0;
      }
      double avgRating = 0;
      for (RatingModel model in list) {
        avgRating += (model.rate ?? 0);
      }
      return avgRating / list.length;
    } catch (e) {
      print('Error calculating Rating for Barber in MongoDB: $e');
      return 0;
    }
  }
}
