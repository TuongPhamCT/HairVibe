import '../Const/database_config.dart';
import 'firebase/firebase_notice_repo.dart';
import 'notice_model.dart';
import 'notice_repo_impl.dart';
import 'mongoDB/mongoDB_notice_repo_impl.dart';

class NoticeRepository {
  late NoticeRepoImplInterface _impl;

  NoticeRepository(String dbType) {
    switch (dbType) {
      case DatabaseConfig.FIREBASE:
        _impl = FirebaseNoticeRepoImpl();
        break;
      case DatabaseConfig.MONGO_DB:
        _impl = MongoDBNoticeRepoImpl();
    }
  }

  Future<void> addNotice(NoticeModel model) async {
    await _impl.addNotice(model);
  }

  Future<bool> updateNotice(NoticeModel model) async {
    return await _impl.updateNotice(model);
  }

  Future<List<NoticeModel>> getAllNotices(String receiverID) async {
    return await _impl.getAllNotices(receiverID);
  }

  Future<List<NoticeModel>> getNewestNoticesByReceiverIDAndRange(String receiverID, int range) async {
    return await _impl.getNewestNoticesByReceiverIDAndRange(receiverID, range);
  }

  Future<int> getUnreadNoticesCount(String receiverID, int range) async {
    return await _impl.getUnreadNoticesCount(receiverID, range);
  }
}