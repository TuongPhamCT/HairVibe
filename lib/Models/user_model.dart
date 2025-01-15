import 'dart:convert';

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
    'image': image ?? "",
    'info': info != null ? jsonEncode(info) : "{}"
  };

  static UserModel fromJson(Map<String, dynamic> json) {
    final dataInfo = jsonDecode(json['info']) as Map<String, Object?>?;

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

  List<String> getBarberImages() {
    if (info!.containsKey(UserInfo.BARBER_IMAGES)) {
      return (info![UserInfo.BARBER_IMAGES] as List<dynamic>).map((e) => e.toString()).toList();
    }
    return [];
  }

  void addBarberImage(String url) {
    if (info!.containsKey(UserInfo.BARBER_IMAGES) == false) {
      info![UserInfo.BARBER_IMAGES] = [];
    }
    (info![UserInfo.BARBER_IMAGES] as List<dynamic>).add(url);
  }

  void removeBarberImage(String url) {
    if (info!.containsKey(UserInfo.BARBER_IMAGES)) {
      (info![UserInfo.BARBER_IMAGES] as List<dynamic>).remove(url);
    }
  }


  List<String> getVoucherIDs() {
    if (info!.containsKey(UserInfo.VOUCHERS)) {
      return info![UserInfo.VOUCHERS] as List<String>;
    }
    return [];
  }

  void removeVoucherByID(String id) {
    getVoucherIDs().removeWhere((voucherID) => voucherID == id);
  }
}

abstract class UserType {
  static const String CUSTOMER = "customer";
  static const String BARBER = "barber";
  static const String ADMIN = "admin";
}

abstract class UserInfo {
  static const String BARBER_IMAGES = "barberImages";
  static const String VOUCHERS = "vouchers";
}