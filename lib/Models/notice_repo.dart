import 'package:cloud_firestore/cloud_firestore.dart';

import 'notice_model.dart';

class NoticeRepository {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;

  void addNoticeToFirestore(NoticeModel model) async {
    try {
      DocumentReference docRef = _storage.collection(NoticeModel.collectionName).doc(model.noticeID);
      await docRef.set(model.toJson()).whenComplete(()
      => print('Notice added to Firestore with ID: ${docRef.id}'));
    } catch (e) {
      print('Error adding Notice to Firestore: $e');
    }
  }

  Future<bool> updateNotice(NoticeModel model) async {
    bool isSuccess = false;

    await _storage.collection(NoticeModel.collectionName)
        .doc(model.noticeID)
        .update(model.toJson())
        .then((_) => isSuccess = true);

    return isSuccess;
  }

  Future<List<NoticeModel>> getAllNotices() async {
    try {
      final QuerySnapshot querySnapshot = await _storage.collection(NoticeModel.collectionName).get();
      final users = querySnapshot
          .docs
          .map((doc) => NoticeModel.fromJson(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
      return users;
    } catch (e) {
      print(e);
      return [];
    }

  }

  Future<List<NoticeModel>> getNewestNoticesByReceiverIDAndRange(String receiverID, int range) async {
    try {
      final QuerySnapshot querySnapshot =
      await _storage.collection(NoticeModel.collectionName)
          .orderBy('noticeID', descending: true)
          .limit(range)
          .get();
      final notices = querySnapshot
          .docs
          .map((doc) => NoticeModel.fromJson(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
      return notices;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<int> getUnreadNoticesCount(String receiverID, int range) async {
    try {
      final QuerySnapshot querySnapshot =
      await _storage.collection(NoticeModel.collectionName)
          .where('isRead', isEqualTo: false)
          .orderBy('noticeID', descending: true)
          .limit(range)
          .get();
      final notices = querySnapshot
          .docs
          .map((doc) => NoticeModel.fromJson(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
      return notices.length;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<String> generateNoticeID() async {
    List<NoticeModel> notices = await getAllNotices();
    int count = notices.length;
    return count.toString().padLeft(8, '0');
  }
}