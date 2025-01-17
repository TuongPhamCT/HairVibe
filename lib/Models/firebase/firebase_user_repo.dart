import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:hairvibe/Models/user_model.dart';
import 'package:hairvibe/Models/user_repo_impl.dart';

class FirebaseUserRepoImpl implements UserRepoImplInterface {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;

  @override
  Future<void> addUser(UserModel user) async {
    try {
      DocumentReference docRef = _storage.collection(UserModel.collectionName).doc(user.userID);
      await docRef.set(user.toJson()).whenComplete(()
        => print('User added to Firestore with ID: ${docRef.id}'));
    } catch (e) {
      print('Error adding user to Firestore: $e');
    }
  }

  @override
  Future<bool> updateUser(UserModel model) async {
    bool isSuccess = false;

    await _storage.collection(UserModel.collectionName)
        .doc(model.userID)
        .update(model.toJson())
        .then((_) => isSuccess = true);

    return isSuccess;
  }

  @override
  Future<UserModel> getUserById(String id) async {
    final DocumentReference<Map<String, dynamic>> collectionRef = _storage.collection(UserModel.collectionName).doc(id);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await collectionRef.get();

    final UserModel user = UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    return user;
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      final QuerySnapshot querySnapshot = await _storage.collection(UserModel.collectionName).get();
      final users = querySnapshot
          .docs
          .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return users;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<List<UserModel>> getAllCustomers() async {
    try {
      final QuerySnapshot querySnapshot = await _storage.collection(UserModel.collectionName)
          .where('userType', isEqualTo: UserType.CUSTOMER).get();
      final customers = querySnapshot
          .docs
          .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return customers;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<List<UserModel>> getAllBarbers() async {
    try {
      final QuerySnapshot querySnapshot = await _storage.collection(UserModel.collectionName)
          .where('userType', isEqualTo: UserType.BARBER).get();
      final barbers = querySnapshot
          .docs
          .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return barbers;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<List<UserModel>> getAllAdmins() async {
    try {
      final QuerySnapshot querySnapshot = await _storage.collection(UserModel.collectionName)
          .where('userType', isEqualTo: UserType.ADMIN).get();
      final barbers = querySnapshot
          .docs
          .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return barbers;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<int> getBarbersCount() async {
    final List<UserModel> users = await getAllBarbers();
    return users.length;
  }

  @override
  Future<int> getCustomersCount() async {
    final List<UserModel> users = await getAllCustomers();
    return users.length;
  }
}
