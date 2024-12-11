import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairvibe/Models/rating_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class RatingRepository {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  void addRatingToFirestore(RatingModel model) async {
    try {
      DocumentReference docRef = _storage.collection(RatingModel.collectionName).doc(model.ratingID);
      await docRef.set(model.toJson()).whenComplete(()
      => print('Ratings added to Firestore with ID: ${docRef.id}'));
    } catch (e) {
      print('Error adding Rating to Firestore: $e');
    }
  }

  void deleteRatingById(String id) async => _storage.collection(RatingModel.collectionName).doc(id).delete();

  Future<bool> updateRating(RatingModel model) async {
    bool isSuccess = false;

    await _storage.collection(RatingModel.collectionName)
        .doc(model.ratingID)
        .update(model.toJson())
        .then((_) => isSuccess = true);

    return isSuccess;
  }

  Future<List<RatingModel>> getAllRatings(String id) async {
    final QuerySnapshot querySnapshot = await _storage.collection(RatingModel.collectionName).get();
    final ratings = querySnapshot
        .docs
        .map((doc) => RatingModel.fromJson(doc as Map<String, dynamic>))
        .toList();
    return ratings;
  }

  Future<List<RatingModel>> getRatingsByBarberId(String id) async {
    final QuerySnapshot querySnapshot = await _storage.collection(RatingModel.collectionName)
        .where('barberID', isEqualTo: id).get();
    final ratings = querySnapshot
        .docs
        .map((doc) => RatingModel.fromJson(doc as Map<String, dynamic>))
        .toList();
    return ratings;
  }

  Future<double> calculateRatingOfBarber(String id) async {
    List<RatingModel> list = await getRatingsByBarberId(id);
    double avgRating = 0;
    for (RatingModel model in list){
      avgRating += (model.rate ?? 0);
    }
    return avgRating / list.length;
  }
}
