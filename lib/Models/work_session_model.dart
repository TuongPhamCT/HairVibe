class WorkSessionModel {
  String? workSessionID;
  String? barberID;
  int? day;

  static String collectionName = 'WorkSessions';

  WorkSessionModel({
    this.workSessionID,
    required this.barberID,
    required this.day
  });

  Map<String, dynamic> toJson() => {
    'barberID': barberID,
    'day': day,
  };

  static WorkSessionModel fromJson(String key, Map<String, dynamic> json) {
    return WorkSessionModel(
      workSessionID: key,
      barberID: json['barberID'] as String,
      day: json['day'] as int,
    );
  }
}