class ServiceModel {

  //String? key;
  String? serviceID;
  String? name;
  int? price;
  int? duration;
  String? info;

  static String collectionName = 'Services';

  ServiceModel(
    {
      this.serviceID,
      required this.name,
      required this.price,
      required this.duration,
      this.info
    }
  );

  Map<String, dynamic> toJson() => {
    'serviceID': serviceID,
    'name': name,
    'price': price,
    'duration': duration,
    'info': info
  };

  static ServiceModel fromJson(String key, Map<String, dynamic> json) {
    return ServiceModel(
      serviceID: key,
      name: json['name'] as String,
      price: json['price'] as int,
      duration: json['duration'] as int,
      info: json['info'] as String,
    );
  }
}