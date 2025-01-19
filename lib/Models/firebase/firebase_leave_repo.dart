import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairvibe/Models/leave_model.dart';
import 'package:hairvibe/Models/leave_repo_impl.dart';

class FirebaseLeaveRepoImpl implements LeaveRepoImplInterface {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;

  @override
  Future<void> addLeave(LeaveModel model) async {
    try {
      DocumentReference docRef = _storage.collection(LeaveModel.collectionName).doc(model.leaveID);
      await docRef.set(model.toJson()).whenComplete(()
      => print('Leave added to Firestore with ID: ${docRef.id}'));
    } catch (e) {
      print('Error adding Leave to Firestore: $e');
    }
  }

  @override
  Future<List<LeaveModel>> getLeavesByBarberId(String id) async {
    final QuerySnapshot querySnapshot = await _storage.collection(LeaveModel.collectionName)
        .where('barberID', isEqualTo: id).get();
    final leaves = querySnapshot
        .docs
        .map((doc) => LeaveModel.fromJson(doc as Map<String, dynamic>))
        .toList();
    return leaves;
  }

  @override
  Future<bool> updateLeave(LeaveModel model) async {
    bool isSuccess = false;

    await _storage.collection(LeaveModel.collectionName)
        .doc(model.leaveID)
        .update(model.toJson())
        .then((_) => isSuccess = true);

    return isSuccess;
  }
}