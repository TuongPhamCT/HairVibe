import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairvibe/Models/rating_model.dart';
import 'package:hairvibe/Models/user_model.dart';

abstract class RatingRepoImplInterface {

  Future<String> addRating(RatingModel model);

  Future<void> deleteRatingById(String barberId, String id);

  Future<bool> updateRating(RatingModel model);

  Future<List<RatingModel>> getRatingsByBarberId(String barberId);

  Future<double> calculateRatingOfBarber(String barberId);
}
