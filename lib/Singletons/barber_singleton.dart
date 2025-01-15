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
    return barber!.getBarberImages();
  }

  void reset() {
    barber = null;
    navigateFromOtherPage = false;
    thisUserRating = null;
  }
}