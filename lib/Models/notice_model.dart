class NoticeModel {
  String? noticeID;
  String? title;
  String? content;

  static String collectionName = 'Notices';

  NoticeModel(
      {
        required this.noticeID,
        required this.title,
        required this.content,
      }
    );

  Map<String, dynamic> toJson() => {
    'noticeID': noticeID,
    'title': title,
    'content': content,
  };

  static NoticeModel fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      noticeID: json['noticeID'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }
}