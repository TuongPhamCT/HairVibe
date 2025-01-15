import 'package:hairvibe/Contract/home_screen_contract.dart';
import 'package:hairvibe/Models/rating_repo.dart';
import 'package:hairvibe/Models/service_model.dart';
import 'package:hairvibe/Models/service_repo.dart';
import 'package:hairvibe/Models/user_repo.dart';
import 'package:hairvibe/Singletons/barber_singleton.dart';
import 'package:hairvibe/Singletons/booking_singleton.dart';

import '../Models/user_model.dart';

class HomeScreenPresenter {
  final HomeScreenContract _view;
  HomeScreenPresenter(this._view);

  final ServiceRepository _serviceRepo = ServiceRepository();
  final UserRepository _userRepo = UserRepository();
  final RatingRepository _ratingRepo = RatingRepository();

  final BookingSingleton _bookingSingleton = BookingSingleton.getInstance();
  final BarberSingleton _barberSingleton = BarberSingleton.getInstance();

  static const maxServiceLength = 4;
  static const maxBarberLength = 3;

  List<ServiceModel> serviceList = [];
  List<UserModel> barberList = [];

  Map<String, double> ratings = {};

  Future<void> getData() async {
    serviceList = await _serviceRepo.getAllServices();
    barberList = await _userRepo.getAllBarbers();
    if (serviceList.length > 4) {
      serviceList = serviceList.getRange(0, maxServiceLength).toList();
    }
    if (barberList.length > 4) {
      barberList = barberList.getRange(0, maxBarberLength).toList();
    }
    for (UserModel barber in barberList) {
      ratings[barber.userID!] = await _ratingRepo.calculateRatingOfBarber(barber.userID!);
    }
    _view.onLoadDataSucceed();
  }

  void handleServicePressed(ServiceModel model) {
    _bookingSingleton.setCacheService(model);
    _view.onServicePressed();
  }

  void handleBarberPressed(UserModel model) {
    _barberSingleton.setBarber(model);
    _view.onBarberPressed();
  }
}