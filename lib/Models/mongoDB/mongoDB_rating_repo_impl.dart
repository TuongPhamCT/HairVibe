import 'package:mongo_dart/mongo_dart.dart';
import 'package:hairvibe/Models/rating_model.dart';
import 'package:hairvibe/Models/rating_repo_impl.dart';

class MongoDBRatingRepoImpl implements RatingRepoImplInterface {
  final Db _db = Db(
      'mongodb://localhost:27017/hairvibe'); // Replace with your MongoDB connection string

 @override
  Future<String> addRating(RatingModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(RatingModel.collectionName);
      await collection.insert(model.toJson());
      print('Rating added to MongoDB with ID: ${model.ratingID}');
      return model.ratingID!;
    } catch (e) {
      print('Error adding Rating to MongoDB: $e');
      return "";
    } finally {
      await _db.close();
    }
  }

  @override
  Future<void> deleteRatingById(String barberId, String id) async {
    try {
      await _db.open();
      final collection = _db.collection(RatingModel.collectionName);
      await collection.remove(where.eq('barberID', barberId).eq('ratingID', id));
      print('Rating deleted for Barber ID: $barberId, Rating ID: $id');
    } catch (e) {
      print('Error deleting Rating from MongoDB: $e');
    } finally {
      await _db.close();
    }
  }

  @override
  Future<bool> updateRating(RatingModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(RatingModel.collectionName);
      final result = await collection.update(
        where.eq('barberID', model.barberID).eq('ratingID', model.ratingID),
        model.toJson(),
      );
      return result['n'] > 0; // Check if any document was updated
    } catch (e) {
      print('Error updating Rating in MongoDB: $e');
      return false;
    } finally {
      await _db.close();
    }
  }

  @override
  Future<List<RatingModel>> getRatingsByBarberId(String barberId) async {
    try {
      await _db.open();
      final collection = _db.collection(RatingModel.collectionName);
      final results = await collection.find(where.eq('barberID', barberId)).toList();
      return results.map((json) => RatingModel.fromJson(json['_id'], json)).toList();
    } catch (e) {
      print('Error fetching Ratings for Barber ID: $e');
      return [];
    } finally {
      await _db.close();
    }
  }

  @override
  Future<double> calculateRatingOfBarber(String barberId) async {
    try {
      List<RatingModel> ratings = await getRatingsByBarberId(barberId);
      if (ratings.isEmpty) {
        return 0.0;
      }
      double avgRating = ratings.map((r) => r.rate ?? 0.0).reduce((a, b) => a + b);
      return avgRating / ratings.length;
    } catch (e) {
      print('Error calculating Rating for Barber ID: $e');
      return 0.0;
    }
  }
}
