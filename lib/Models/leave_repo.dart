import 'package:hairvibe/Models/leave_model.dart';

import '../Const/database_config.dart';
import 'firebase/firebase_leave_repo.dart';
import 'leave_repo_impl.dart';
import 'mongoDB/mongoDB_leave_repo_impl.dart';

class LeaveRepository {
  late LeaveRepoImplInterface _impl;

  LeaveRepository(String dbType) {
    switch (dbType) {
      case DatabaseConfig.FIREBASE:
        _impl = FirebaseLeaveRepoImpl();
        break;
      case DatabaseConfig.MONGO_DB:
        _impl = MongoDBLeaveRepoImpl();
    }
  }

  Future<void> addLeave(LeaveModel model) async {
    return await _impl.addLeave(model);
  }

  Future<List<LeaveModel>> getLeavesByBarberId(String id) async {
    return await _impl.getLeavesByBarberId(id);
  }

  Future<bool> updateLeave(LeaveModel model) async {
    return await _impl.updateLeave(model);
  }
}
