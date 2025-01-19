import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairvibe/Models/user_model.dart';
import 'package:hairvibe/Models/work_session_model.dart';

abstract class WorkSessionRepoImplInterface {

  Future<String> addWorkSession(WorkSessionModel model);

  Future<void> deleteWorkSessionById(String userId, String id);

  Future<List<WorkSessionModel>> getWorkSessionsByBarberId(String id);
}