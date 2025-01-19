import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairvibe/Models/service_model.dart';

import '../service_repo_impl.dart';

class FirebaseServiceRepoImpl implements ServiceRepoImplInterface {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;

  @override
  Future<String> addService(ServiceModel model) async {
    try {
      DocumentReference docRef = _storage.collection(ServiceModel.collectionName).doc();
      await docRef.set(model.toJson()).whenComplete(()
      => print('Service added to Firestore with ID: ${docRef.id}')
      );
      return docRef.id;
    } catch (e) {
      print('Error adding Service to Firestore: $e');
      return "";
    }
  }

  @override
  Future<bool> updateService(ServiceModel model) async {
    bool isSuccess = false;

    await _storage.collection(ServiceModel.collectionName)
        .doc(model.serviceID)
        .update(model.toJson())
        .then((_) => isSuccess = true);

    return isSuccess;
  }

  @override
  Future<void> deleteServiceById(String id) async => _storage.collection(ServiceModel.collectionName).doc(id).delete();

  @override
  Future<List<ServiceModel>> getAllServices() async {
    try {
      final QuerySnapshot querySnapshot = await _storage.collection(ServiceModel.collectionName).get();
      final ratings = querySnapshot
          .docs
          .map((doc) => ServiceModel.fromJson(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
      return ratings;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
