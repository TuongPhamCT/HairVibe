import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairvibe/Models/user_model.dart';
import 'package:hairvibe/Models/user_repo_impl.dart';

import '../Const/database_config.dart';
import 'firebase/firebase_user_repo.dart';
import 'mongoDB/mongoDB_user_repo_impl.dart';

class UserRepository {
  late UserRepoImplInterface _impl;

  UserRepository(String dbType) {
    switch (dbType) {
      case DatabaseConfig.FIREBASE:
        _impl = FirebaseUserRepoImpl();
        break;
      case DatabaseConfig.MONGO_DB:
        _impl = MongoDBUserRepoImpl();
    }
  }

  Future<void> addUser(UserModel user) async {
    await _impl.addUser(user);
  }

  Future<bool> updateUser(UserModel model) async {
    return await _impl.updateUser(model);
  }

  Future<UserModel> getUserById(String id) async {
    return await _impl.getUserById(id);
  }

  Future<List<UserModel>> getAllUsers() async {
    return await _impl.getAllBarbers();
  }

  Future<List<UserModel>> getAllCustomers() async {
    return await _impl.getAllCustomers();
  }

  Future<List<UserModel>> getAllBarbers() async {
    return await _impl.getAllBarbers();
  }

  Future<List<UserModel>> getAllAdmins() async {
    return await _impl.getAllAdmins();
  }

  Future<int> getBarbersCount() async {
    final List<UserModel> users = await getAllBarbers();
    return users.length;
  }

  Future<int> getCustomersCount() async {
    final List<UserModel> users = await getAllCustomers();
    return users.length;
  }
}
