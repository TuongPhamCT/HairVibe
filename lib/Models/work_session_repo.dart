import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairvibe/Models/work_session_model.dart';

class WorkSessionRepository {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;

  void addWorkSessionToFirestore(WorkSessionModel model) async {
    try {
      DocumentReference docRef = _storage.collection(WorkSessionModel.collectionName).doc(model.workSessionID);
      await docRef.set(model.toJson()).whenComplete(()
      => print('WorkSession added to Firestore with ID: ${docRef.id}'));
    } catch (e) {
      print('Error adding WorkSession to Firestore: $e');
    }
  }

  void deleteWorkSessionById(String id) async => _storage.collection(WorkSessionModel.collectionName).doc(id).delete();

  Future<List<WorkSessionModel>> getWorkSessionsByBarberId(String id) async {
    final QuerySnapshot querySnapshot = await _storage.collection(WorkSessionModel.collectionName)
        .where('barberID', isEqualTo: id).get();
    final leaves = querySnapshot
        .docs
        .map((doc) => WorkSessionModel.fromJson(doc as Map<String, dynamic>))
        .toList();
    return leaves;
  }
}