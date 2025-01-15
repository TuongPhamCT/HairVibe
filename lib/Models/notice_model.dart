import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:string_validator/string_validator.dart';

class NoticeModel {
  String? noticeID;
  String? receiverID;
  DateTime? date;
  String? content;
  bool? isRead = false;

  static String collectionName = 'Notices';

  NoticeModel(
      {
        this.noticeID,
        required this.receiverID,
        required this.date,
        required this.content,
        this.isRead
      }
    );

  Map<String, dynamic> toJson() => {
    'receiverID': receiverID,
    'title': date,
    'content': content,
    'isRead': isRead,
  };

  static NoticeModel fromJson(String key, Map<String, dynamic> json) {
    return NoticeModel(
      noticeID: key,
      receiverID: json['receiverID'] as String,
      date: (json['date'] as Timestamp).toDate(),
      content: json['content'] as String,
      isRead: json['isRead'] as bool
    );
  }
}