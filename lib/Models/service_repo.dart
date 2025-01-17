import 'package:hairvibe/Models/service_model.dart';
import 'package:hairvibe/Models/service_repo_impl.dart';

import '../Const/database_config.dart';
import 'firebase/firebase_service_repo.dart';

class ServiceRepository {
  late ServiceRepoImplInterface _impl;

  ServiceRepository(String dbType) {
    switch (dbType) {
      case DatabaseConfig.FIREBASE:
        _impl = FirebaseServiceRepoImpl();
        break;
      case DatabaseConfig.MONGO_DB:
        _impl = MongoDBServiceRepoImpl();
    }
  }

  Future<String> addService(ServiceModel model) async {
    return await _impl.addService(model);
  }

  Future<bool> updateService(ServiceModel model) async {
    return await _impl.updateService(model);
  }

  Future<void> deleteServiceById(String id) async {
    await _impl.deleteServiceById(id);
  }

  Future<List<ServiceModel>> getAllServices() async {
    return await _impl.getAllServices();
  }
}
