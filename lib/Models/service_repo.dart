import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairvibe/Models/appointment_model.dart';
import 'package:hairvibe/Models/appointment_repo.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:hairvibe/Models/service_model.dart';

class ServiceRepository {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> addServiceToFirestore(ServiceModel model) async {
    try {
      DocumentReference docRef = _storage.collection(ServiceModel.collectionName).doc(model.serviceID);
      await docRef.set(model.toJson()).whenComplete(()
      => print('Service added to Firestore with ID: ${docRef.id}')
      );
      return docRef.id;
    } catch (e) {
      print('Error adding Service to Firestore: $e');
      return "";
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

  Future<void> deleteServiceById(String id) async => _storage.collection(ServiceModel.collectionName).doc(id).delete();

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

  Future<int> getServicesCount() async {
    final List<ServiceModel> services = await getAllServices();
    return services.length;
  }
}
