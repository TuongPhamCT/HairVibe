class ServiceTypeModel {
  String? serviceTypeID;
  String? name;

  static String collectionName = 'ServiceTypes';

  ServiceTypeModel(
      {
        required this.serviceTypeID,
        required this.name
      }
    );

  Map<String, dynamic> toJson() => {
    'serviceTypeID': serviceTypeID,
    'name': name
  };

  static ServiceTypeModel fromJson(Map<String, dynamic> json) {
    return ServiceTypeModel(
      serviceTypeID: json['serviceTypeID'] as String,
      name: json['name'] as String
    );
  }
}