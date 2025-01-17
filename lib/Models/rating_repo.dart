import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairvibe/Models/rating_model.dart';
import 'package:hairvibe/Models/rating_repo_impl.dart';
import 'package:hairvibe/Models/user_model.dart';

import '../Const/database_config.dart';
import 'firebase/firebase_rating_repo.dart';

class RatingRepository {
  late RatingRepoImplInterface _impl;

  RatingRepository(String dbType) {
    switch (dbType) {
      case DatabaseConfig.FIREBASE:
        _impl = FirebaseRatingRepoImpl();
        break;
      case DatabaseConfig.MONGO_DB:
        _impl = MongoDBRatingRepoImpl();
    }
  }

  Future<String> addRating(RatingModel model) async {
    return await _impl.addRating(model);
  }

  Future<void> deleteRatingById(String barberId, String id) async {
    await _impl.deleteRatingById(barberId, id);
  }

  Future<bool> updateRating(RatingModel model) async {
    return await _impl.updateRating(model);
  }

  Future<List<RatingModel>> getRatingsByBarberId(String barberId) async {
    return await _impl.getRatingsByBarberId(barberId);
  }

  Future<double> calculateRatingOfBarber(String barberId) async {
    List<RatingModel> list = await getRatingsByBarberId(barberId);
    if (list.isEmpty) {
      return 0;
    }
    double avgRating = 0;
    for (RatingModel model in list) {
      avgRating += (model.rate ?? 0);
    }
    return avgRating / list.length;
  }
}
