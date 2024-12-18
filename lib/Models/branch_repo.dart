import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairvibe/Models/branch_model.dart';

class BranchRepository {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;

  void addBranchToFirestore(BranchModel model) async {
    try {
      DocumentReference docRef = _storage.collection(BranchModel.collectionName).doc(model.branchID);
      await docRef.set(model.toJson()).whenComplete(()
        => print('Branch added to Firestore with ID: ${docRef.id}'));
    } catch (e) {
      print('Error adding Branch to Firestore: $e');
    }
  }

  Future<bool> updateBranch(BranchModel model) async {
    bool isSuccess = false;

    await _storage.collection(BranchModel.collectionName)
        .doc(model.branchID)
        .update(model.toJson())
        .then((_) => isSuccess = true);

    return isSuccess;
  }

  void deleteBranchById(String id) async => _storage.collection(BranchModel.collectionName).doc(id).delete();

  Future<List<BranchModel>> getAllBranches() async {
    final QuerySnapshot querySnapshot = await _storage.collection(BranchModel.collectionName).get();
    final branches = querySnapshot
        .docs
        .map((doc) => BranchModel.fromJson(doc as Map<String, dynamic>))
        .toList();
    return branches;
  }
}