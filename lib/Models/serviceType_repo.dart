import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairvibe/Models/serviceType_model.dart';

class ServiceTypeRepository {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;

  void addServiceTypeToFirestore(ServiceTypeModel model) async {
    try {
      DocumentReference docRef = _storage.collection(ServiceTypeModel.collectionName).doc(model.serviceTypeID);
      await docRef.set(model.toJson()).whenComplete(()
      => print('Service Type added to Firestore with ID: ${docRef.id}'));
    } catch (e) {
      print('Error adding Service Type to Firestore: $e');
    }
  }

  Future<bool> updateServiceType(ServiceTypeModel model) async {
    bool isSuccess = false;

    await _storage.collection(ServiceTypeModel.collectionName)
        .doc(model.serviceTypeID)
        .update(model.toJson())
        .then((_) => isSuccess = true);

    return isSuccess;
  }

  void deleteServiceTypeById(String id) async => _storage.collection(ServiceTypeModel.collectionName).doc(id).delete();

  Future<List<ServiceTypeModel>> getAllServiceTypes(String id) async {
    final QuerySnapshot querySnapshot = await _storage.collection(ServiceTypeModel.collectionName).get();
    final ratings = querySnapshot
        .docs
        .map((doc) => ServiceTypeModel.fromJson(doc as Map<String, dynamic>))
        .toList();
    return ratings;
  }

  Future<ServiceTypeModel> getServiceTypeById(String id) async {
    final DocumentSnapshot doc = await _storage.collection(ServiceTypeModel.collectionName).doc(id).get();
    return ServiceTypeModel.fromJson(doc.data() as Map<String, dynamic>);
  }
}