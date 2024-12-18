class UserModel {

  String? userID;
  String? email;
  String? name;
  String? phoneNumber;
  String? userType;
  String? image;
  Map<String, Object?>? info = {};

  static String collectionName = 'Users';

  UserModel(
      {
        this.userID,
        this.email,
        this.name,
        this.phoneNumber,
        this.userType,
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
    final dataInfo = json['otherInfo'] as Map<String, Object?>?;

    return UserModel(
      userID: json['userID'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      userType: json['userType'] as String,
      image: json['image'] as String?,
      info: dataInfo
    );
  }
}

abstract class UserType {
  static const String CUSTOMER = "customer";
  static const String BARBER = "barber";
  static const String ADMIN = "admin";
}

abstract class UserInfo {
  static const String BARBER_IMAGES = "barberImages";
}