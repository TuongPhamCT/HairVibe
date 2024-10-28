class UserModel {

  //String? key;
  String? userID;
  String? name;
  String? phoneNumber;
  String? userType;
  String? info;
  String? image;

  static String collectionName = 'Users';

  UserModel(
      {
        //this.key,
        required this.userID,
        required this.name,
        required this.phoneNumber,
        required this.userType,
        this.image,
        this.info
      }
    );

  Map<String, dynamic> toJson() => {
    'userID': userID,
    'name': name,
    'phoneNumber': phoneNumber,
    'userType': userType,
    'image': image,
    'info': info
  };

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      //key: key,
      userID: json['userID'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      userType: json['userType'] as String,
      image: json['image'] as String,
      info: json['info'] as String,
    );
  }
}