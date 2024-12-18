class LeaveModel {
  String? leaveID;
  String? barberID;
  DateTime? startDate;
  DateTime? endDate;

  static String collectionName = 'Leaves';

  LeaveModel(
      {
        required this.leaveID,
        required this.barberID,
        required this.startDate,
        required this.endDate
      }
    );

  Map<String, dynamic> toJson() => {
    'leaveID': leaveID,
    'barberID': barberID,
    'startDate': startDate,
    'endDate': endDate
  };

  static LeaveModel fromJson(Map<String, dynamic> json) {
    return LeaveModel(
      leaveID: json['leaveID'] as String,
      barberID: json['barberID'] as String,
      startDate: json['startDate'].toDate(),
      endDate: json['endDate'].toDate(),
    );
  }
}