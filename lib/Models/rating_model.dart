class RatingModel {

  //String? key;
  String? ratingID;
  String? userID;
  String? barberID;
  int? rate;
  DateTime? date;
  String? info;

  static String collectionName = 'Ratings';

  RatingModel(
    {
      required this.ratingID,
      required this.userID,
      required this.barberID,
      required this.date,
      required this.rate,
      this.info
    }
  );

  Map<String, dynamic> toJson() => {
    'ratingID': ratingID,
    'userID': userID,
    'barberID': barberID,
    'rate': rate,
    'date': date,
    'info': info
  };

  static RatingModel fromJson(Map<String, dynamic> json) {
    return RatingModel(
      //key: key,
      ratingID: json['ratingID'] as String,
      userID: json['userID'] as String,
      barberID: json['barberID'] as String,
      rate: json['rate'] as int,
      date: json['date'] as DateTime,
      info: json['info'] as String,
    );
  }
}