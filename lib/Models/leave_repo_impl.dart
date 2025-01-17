import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairvibe/Models/leave_model.dart';

abstract class LeaveRepoImplInterface {

  void addLeave(LeaveModel model);

  Future<List<LeaveModel>> getLeavesByBarberId(String id);

  Future<bool> updateLeave(LeaveModel model);
}