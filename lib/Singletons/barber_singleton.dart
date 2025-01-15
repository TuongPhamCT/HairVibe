import '../Models/rating_model.dart';
import '../Models/user_model.dart';

class BarberSingleton {
  static BarberSingleton? _instance;

  static BarberSingleton getInstance() {
    _instance ??= BarberSingleton();
    return _instance!;
  }

  UserModel? barber;
  bool navigateFromOtherPage = false;
  RatingModel? thisUserRating;

  void setBarber(UserModel barber) {
    this.barber = barber;
    thisUserRating = null;
  }

  void setThisUserRating(RatingModel rating) {
    thisUserRating = rating;
  }

  List<String> getBarberImageUrls() {
    if (barber!.info == null || barber!.info!.containsKey(UserInfo.BARBER_IMAGES) == false) {
      return [];
    }
    return barber!.info![UserInfo.BARBER_IMAGES] as List<String>;
  }
}