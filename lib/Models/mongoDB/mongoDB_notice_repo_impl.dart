import 'package:mongo_dart/mongo_dart.dart';
import 'package:hairvibe/Models/user_model.dart';
import '../notice_model.dart';

class MongoDBNoticeRepoImplementation {
  final Db _db = Db(
      'mongodb://localhost:27017/hairvibe'); // Replace with your MongoDB connection string
  final String userCollectionName = UserModel.collectionName;

  Future<void> addNoticeToMongo(NoticeModel model) async {
    try {
      await _db.open();
      final collection = _db.collection('notices');
      await collection.insertOne({
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

  Future<bool> updateNotice(NoticeModel model) async {
    try {
      await _db.open();
      final collection = _db.collection('notices');
      final result = await collection.updateOne(
        where.eq('noticeID', model.noticeID),
        modify.set('data', model.toJson()),
      );
      return result.isSuccess;
    } catch (e) {
      print('Error updating Notice in MongoDB: $e');
      return false;
    } finally {
      await _db.close();
    }
  }

  Future<List<NoticeModel>> getAllNotices(String receiverID) async {
    try {
      await _db.open();
      final collection = _db.collection('notices');
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

  Future<List<NoticeModel>> getNewestNoticesByReceiverIDAndRange(
      String receiverID, int range) async {
    try {
      await _db.open();
      final collection = _db.collection('notices');
      final results = await collection
          .find(where
              .eq('receiverID', receiverID)
              .sort({'noticeID': -1}).limit(range))
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

  Future<int> getUnreadNoticesCount(String receiverID, int range) async {
    try {
      await _db.open();
      final collection = _db.collection('notices');
      final results = await collection
          .find(where
              .eq('receiverID', receiverID)
              .eq('isRead', false)
              .sort({'noticeID': -1}).limit(range))
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
