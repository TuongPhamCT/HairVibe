class UserModel {

  String? userID;
  String? email;
  String? name;
  String? phoneNumber;
  String? userType;
  String? info;
  String? image;

  static String collectionName = 'Users';

  UserModel(
      {
        required this.userID,
        required this.email,
        required this.name,
        required this.phoneNumber,
        required this.userType,
        this.image,
        this.info
      }
    );

  Map<String, dynamic> toJson() => {
    'userID': userID,
    'email': email,
    'name': name,
    'phoneNumber': phoneNumber,
    'userType': userType,
    'image': image,
    'info': info
  };

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      userID: json['userID'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      userType: json['userType'] as String,
      image: json['image'] as String,
      info: json['info'] as String,
    );
  }

  static const String CUSTOMER = "customer";
  static const String BARBER = "barber";
  static const String ADMIN = "admin";
}