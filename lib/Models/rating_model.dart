class RatingModel {

  String? ratingID;
  String? userID;
  String? barberID;
  double? rate;
  DateTime? date;
  String? info;

  static String collectionName = 'Ratings';

  RatingModel(
    {
      this.ratingID,
      required this.userID,
      required this.barberID,
      required this.date,
      required this.rate,
      this.info
    }
  );

  Map<String, dynamic> toJson() => {
    'userID': userID,
    'barberID': barberID,
    'rate': rate,
    'date': date,
    'info': info
  };

  static RatingModel fromJson(String key, Map<String, dynamic> json) {
    return RatingModel(
      ratingID: key,
      userID: json['userID'] as String,
      barberID: json['barberID'] as String,
      rate: json['rate'] as double,
      date: json['date'] as DateTime,
      info: json['info'] as String,
    );
  }
}