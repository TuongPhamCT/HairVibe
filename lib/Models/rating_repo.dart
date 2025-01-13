import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairvibe/Models/rating_model.dart';
import 'package:hairvibe/Models/user_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class RatingRepository {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addRatingToFirestore(RatingModel model) async {
    try {
      DocumentReference docRef
        = _storage.collection(UserModel.collectionName)
            .doc(model.barberID)
            .collection(RatingModel.collectionName)
            .doc(model.ratingID);
      await docRef.set(model.toJson()).whenComplete(()
      => print('Ratings added to Firestore with ID: ${docRef.id}'));
    } catch (e) {
      print('Error adding Rating to Firestore: $e');
    }
  }

  Future<void> deleteRatingById(String barberId, String id) async
    => _storage.collection(UserModel.collectionName)
          .doc(barberId)
          .collection(RatingModel.collectionName)
          .doc(id)
          .delete();

  Future<bool> updateRating(RatingModel model) async {
    bool isSuccess = false;

    await _storage.collection(UserModel.collectionName)
        .doc(model.barberID)
        .collection(RatingModel.collectionName)
        .doc(model.ratingID)
        .update(model.toJson())
        .then((_) => isSuccess = true);

    return isSuccess;
  }

  Future<List<RatingModel>> getRatingsByBarberId(String barberId) async {
    try {
      final QuerySnapshot querySnapshot
        = await _storage.collection(UserModel.collectionName)
            .doc(barberId)
            .collection(RatingModel.collectionName)
            .get();
      final ratings = querySnapshot
          .docs
          .map((doc) => RatingModel.fromJson(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
      return ratings;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<double> calculateRatingOfBarber(String barberId) async {
    List<RatingModel> list = await getRatingsByBarberId(barberId);
    if (list.isEmpty) {
      return 0;
    }
    double avgRating = 0;
    for (RatingModel model in list){
      avgRating += (model.rate ?? 0);
    }
    return avgRating / list.length;
  }
}
