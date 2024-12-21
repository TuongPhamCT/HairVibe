class WorkSessionModel {
  String? workSessionID;
  String? barberID;
  int? day;

  static String collectionName = 'WorkSessions';

  WorkSessionModel({
    required this.workSessionID,
    required this.barberID,
    required this.day
  });

  Map<String, dynamic> toJson() => {
    'workSessionID': workSessionID,
    'barberID': barberID,
    'day': day,
  };

  static WorkSessionModel fromJson(Map<String, dynamic> json) {
    return WorkSessionModel(
      workSessionID: json['leaveID'] as String,
      barberID: json['barberID'] as String,
      day: json['day'] as int,
    );
  }
}