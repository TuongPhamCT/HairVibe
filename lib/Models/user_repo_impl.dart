import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:hairvibe/Models/user_model.dart';

abstract class UserRepoImplInterface {

  Future<void> addUser(UserModel user);

  Future<bool> updateUser(UserModel model);

  Future<UserModel> getUserById(String id);

  Future<List<UserModel>> getAllUsers();

  Future<List<UserModel>> getAllCustomers();

  Future<List<UserModel>> getAllBarbers();

  Future<List<UserModel>> getAllAdmins();

  Future<int> getBarbersCount();

  Future<int> getCustomersCount();
}
