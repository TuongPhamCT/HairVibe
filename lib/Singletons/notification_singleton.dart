import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairvibe/Facades/authenticator_facade.dart';
import 'package:hairvibe/Models/notice_repo.dart';
import 'package:hairvibe/Singletons/user_singleton.dart';
import 'package:hairvibe/observers/notification_subcriber.dart';

import '../Models/notice_model.dart';
import '../Models/user_model.dart';

class NotificationSingleton {
  static NotificationSingleton? _instance;
  static NotificationSingleton getInstance() {
    _instance ??= NotificationSingleton();
    return _instance!;
  }

  final NoticeRepository _noticeRepo = NoticeRepository();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final AuthenticatorFacade _auth = AuthenticatorFacade();

  List<NotificationSubscriber> subscribers = [];

  StreamSubscription? _subscription;
  late CollectionReference<Map<String, dynamic>> _noticeDocs;

  List<NoticeModel> notifications = [];
  int _unreadCount = 0;

  void initialize() {
    String userID = UserSingleton.getInstance().currentUser!.userID!;
    _noticeDocs = firestore.collection(UserModel.collectionName)
                            .doc(userID)
                            .collection(NoticeModel.collectionName);
    _subscription = _noticeDocs
        .where('receiverID', isEqualTo: _auth.userId)
        .snapshots()
        .listen((snapshot) async {
          await _updateNotificationsFromFireStore(snapshot);
        });
  }

  Future<void> _updateNotificationsFromFireStore(QuerySnapshot<Map<String, dynamic>> snapshot) async {
    print('Received new data from Firestore (${snapshot.docs})');
    final noticeList = snapshot.docs.map((doc) => NoticeModel.fromJson(doc.id, doc.data())).toList();

    if (notifications.length == noticeList.length) {
      print('No change');
    } else {
      print('Updating notice with Firestore data ($noticeList)');
      notifications = noticeList;
      _calculateUnreadCount();
      notifySubscribers();
    }
  }

  void _calculateUnreadCount() {
    int result = 0;
    for (NoticeModel notice in notifications) {
      if (notice.isRead == false) {
        result ++;
      }
    }
    _unreadCount = result;
  }

  int getUnreadCount() {
    return _unreadCount;
  }

  Future<void> readAll() async {
    for (NoticeModel model in notifications) {
      if (model.isRead == false) {
        model.isRead = true;
        await _noticeRepo.updateNotice(model);
      }
    }
  }

  void dispose() {
    _subscription?.cancel();
  }

  void subscribe(NotificationSubscriber subscriber) {
    subscribers.add(subscriber);
  }

  void unsubscribe(NotificationSubscriber subscriber) {
    subscribers.remove(subscriber);
  }

  void notifySubscribers() {
    for (var subscriber in subscribers) {
      subscriber.updateNotification();
    }
  }
}