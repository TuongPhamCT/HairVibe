import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairvibe/Models/user_model.dart';
import 'package:hairvibe/Models/work_session_model.dart';
import 'package:hairvibe/Models/work_session_repo_impl.dart';

import '../Const/database_config.dart';
import 'firebase/firebase_work_session_repo.dart';
import 'mongoDB/mongoDB_work_session_repo_impl.dart';

class WorkSessionRepository {
  late WorkSessionRepoImplInterface _impl;

  WorkSessionRepository(String dbType) {
    switch (dbType) {
      case DatabaseConfig.FIREBASE:
        _impl = FirebaseWorkSessionRepoImpl();
        break;
      case DatabaseConfig.MONGO_DB:
        _impl = MongoDBWorkSessionRepoImpl();
    }
  }

  Future<String> addWorkSession(WorkSessionModel model) async {
    return await _impl.addWorkSession(model);
  }

  Future<void> deleteWorkSessionById(String userId, String id) async {
    await _impl.deleteWorkSessionById(userId, id);
  }

  Future<List<WorkSessionModel>> getWorkSessionsByBarberId(String id) async {
    return await _impl.getWorkSessionsByBarberId(id);
  }
}