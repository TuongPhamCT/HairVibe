class ServiceModel {

  //String? key;
  String? serviceID;
  String? name;
  String? serviceTypeID;
  int? price;
  int? duration;
  String? info;

  static String collectionName = 'Services';

  ServiceModel(
    {
      //this.key,
      required this.serviceID,
      required this.name,
      required this.serviceTypeID,
      required this.price,
      required this.duration,
      this.info
    }
  );

  Map<String, dynamic> toJson() => {
    'serviceID': serviceID,
    'name': name,
    'serviceTypeID': serviceTypeID,
    'price': price,
    'duration': duration,
    'info': info
  };

  static ServiceModel fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      //key: key,
      serviceID: json['serviceID'] as String,
      name: json['name'] as String,
      serviceTypeID: json['serviceTypeID'] as String,
      price: json['price'] as int,
      duration: json['duration'] as int,
      info: json['info'] as String,
    );
  }
}