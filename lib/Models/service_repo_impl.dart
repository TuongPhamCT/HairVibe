import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairvibe/Models/service_model.dart';

abstract class ServiceRepoImpl {

  Future<String> addService(ServiceModel model);

  Future<bool> updateService(ServiceModel model);

  Future<void> deleteServiceById(String id);

  Future<List<ServiceModel>> getAllServices();
}
