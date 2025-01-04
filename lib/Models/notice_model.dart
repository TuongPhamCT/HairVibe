class NoticeModel {
  String? noticeID;
  String? receiverID;
  DateTime? date;
  String? content;
  bool? isRead = false;

  static String collectionName = 'Notices';

  NoticeModel(
      {
        required this.noticeID,
        required this.receiverID,
        required this.date,
        required this.content,
        this.isRead
      }
    );

  Map<String, dynamic> toJson() => {
    'noticeID': noticeID,
    'receiverID': receiverID,
    'title': date,
    'content': content,
    'isRead': isRead,
  };

  static NoticeModel fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      noticeID: json['noticeID'] as String,
      receiverID: json['receiverID'] as String,
      date: json['date'] as DateTime,
      content: json['content'] as String,
      isRead: json['isRead'] as bool
    );
  }
}