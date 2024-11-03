import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:hairvibe/Models/service_model.dart';

class ServiceRepository {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  void addServiceToFirestore(ServiceModel model) async {
    try {
      DocumentReference docRef = _storage.collection(ServiceModel.collectionName).doc(model.serviceID);
      await docRef.set(model.toJson()).whenComplete(()
      => print('Service added to Firestore with ID: ${docRef.id}'));
    } catch (e) {
      print('Error adding Service to Firestore: $e');
    }
  }

  Future<bool> updateService(ServiceModel model) async {
    bool isSuccess = false;

    await _storage.collection(ServiceModel.collectionName)
        .doc(model.serviceID)
        .update(model.toJson())
        .then((_) => isSuccess = true);

    return isSuccess;
  }

  void deleteServiceById(String id) async => _storage.collection(ServiceModel.collectionName).doc(id).delete();

  Future<List<ServiceModel>> getAllServices(String id) async {
    final QuerySnapshot querySnapshot = await _storage.collection(ServiceModel.collectionName).get();
    final ratings = querySnapshot
        .docs
        .map((doc) => ServiceModel.fromJson(doc as Map<String, dynamic>))
        .toList();
    return ratings;
  }
}
