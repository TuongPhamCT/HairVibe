import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairvibe/Models/user_model.dart';
import 'package:hairvibe/Models/work_session_model.dart';

class WorkSessionRepository {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;

  Future<String> addWorkSessionToFirestore(WorkSessionModel model) async {
    try {
      DocumentReference docRef = _storage.collection(UserModel.collectionName)
                                          .doc(model.barberID)
                                          .collection(WorkSessionModel.collectionName)
                                          .doc();
      await docRef.set(model.toJson()).whenComplete(()
      => print('WorkSession added to Firestore with ID: ${docRef.id}'));
      return docRef.id;
    } catch (e) {
      print('Error adding WorkSession to Firestore: $e');
      return "";
    }
  }

  void deleteWorkSessionById(String userId, String id) async
    => _storage.collection(UserModel.collectionName)
                .doc(userId)
                .collection(WorkSessionModel.collectionName)
                .doc(id)
                .delete();

  Future<List<WorkSessionModel>> getWorkSessionsByBarberId(String id) async {
    try {
      final QuerySnapshot querySnapshot =
        await _storage.collection(UserModel.collectionName)
                      .doc(id)
                      .collection(WorkSessionModel.collectionName)
                      .get();
      final sessions = querySnapshot
          .docs
          .map((doc) => WorkSessionModel.fromJson(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
      return sessions;
    } catch (e) {
      print(e);
      return [];
    }
  }
}