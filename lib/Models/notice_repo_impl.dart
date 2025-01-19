import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairvibe/Models/user_model.dart';

import 'notice_model.dart';

abstract class NoticeRepoImplInterface {

  Future<void> addNotice(NoticeModel model);

  Future<bool> updateNotice(NoticeModel model);

  Future<List<NoticeModel>> getAllNotices(String receiverID);

  Future<List<NoticeModel>> getNewestNoticesByReceiverIDAndRange(String receiverID, int range);

  Future<int> getUnreadNoticesCount(String receiverID, int range);
}