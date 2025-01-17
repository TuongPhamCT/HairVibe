import 'package:mongo_dart/mongo_dart.dart';
import 'package:hairvibe/Models/user_model.dart';
import '../notice_model.dart';
import 'package:hairvibe/Models/notice_repo_impl.dart';

class MongoDBNoticeRepoImpl implements NoticeRepoImplInterface {
  final Db _db = Db(
      'mongodb://localhost:27017/hairvibe'); // Replace with your MongoDB connection string

  @override
  Future<void> addNotice(NoticeModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(UserModel.collectionName);
      await collection.insert({
        ...model.toJson(),
        'receiverID': model.receiverID,
      });
      print('Notice added to MongoDB for Receiver ID: ${model.receiverID}');
    } catch (e) {
      print('Error adding Notice to MongoDB: $e');
    } finally {
      await _db.close();
    }
  }

  @override
  Future<bool> updateNotice(NoticeModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(UserModel.collectionName);
      final result = await collection.update(
        where.eq('noticeID', model.noticeID).eq('receiverID', model.receiverID),
        model.toJson(),
      );
      return result['n'] > 0; // Check if any document was updated
    } catch (e) {
      print('Error updating Notice in MongoDB: $e');
      return false;
    } finally {
      await _db.close();
    }
  }

  @override
  Future<List<NoticeModel>> getAllNotices(String receiverID) async {
    try {
      await _db.open();
      final collection = _db.collection(UserModel.collectionName);
      final results =
          await collection.find(where.eq('receiverID', receiverID)).toList();
      return results
          .map((json) => NoticeModel.fromJson(json['_id'], json))
          .toList();
    } catch (e) {
      print('Error fetching all Notices from MongoDB: $e');
      return [];
    } finally {
      await _db.close();
    }
  }

  @override
  Future<List<NoticeModel>> getNewestNoticesByReceiverIDAndRange(
      String receiverID, int range) async {
    try {
      await _db.open();
      final collection = _db.collection(UserModel.collectionName);
      final results = await collection
          .find(where
              .eq('receiverID', receiverID)
              .sortBy('noticeID', descending: true)
              .limit(range))
          .toList();
      return results
          .map((json) => NoticeModel.fromJson(json['_id'], json))
          .toList();
    } catch (e) {
      print('Error fetching newest Notices from MongoDB: $e');
      return [];
    } finally {
      await _db.close();
    }
  }

  @override
  Future<int> getUnreadNoticesCount(String receiverID, int range) async {
    try {
      await _db.open();
      final collection = _db.collection(UserModel.collectionName);
      final results = await collection
          .find(where
              .eq('receiverID', receiverID)
              .eq('isRead', false)
              .sortBy('noticeID', descending: true)
              .limit(range))
          .toList();
      return results.length;
    } catch (e) {
      print('Error fetching unread Notices count from MongoDB: $e');
      return 0;
    } finally {
      await _db.close();
    }
  }
}
