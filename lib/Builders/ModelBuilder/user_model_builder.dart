import '../../Models/user_model.dart';

class UserModelBuilder {
  UserModel _model = UserModel();

  UserModelBuilder();

  void setUser(UserModel user) {
    _model = user;
  }

  void setUserID(String id) {
    _model.userID = id;
  }

  void setEmail(String email) {
    _model.email = email;
  }

  void setAvatar(String url) {
    _model.image = url;
  }

  void setPhoneNumber(String phone) {
    _model.phoneNumber = phone;
  }

  void setUserType(String userType) {
    _model.userType = userType;
  }

  void addBarberImage(String url) {
    if (_model.userType != UserType.BARBER) {
      return;
    }
    List<String> imagePaths = _model.info![UserInfo.BARBER_IMAGES] as List<String>;
    imagePaths.add(url);
  }

  void setBarberImages(List<String> urls) {
    if (_model.userType != UserType.BARBER) {
      return;
    }
    _model.info![UserInfo.BARBER_IMAGES] = urls;
  }

  UserModel build() {
    return _model;
  }

  void reset() {
    _model = UserModel();
  }
}