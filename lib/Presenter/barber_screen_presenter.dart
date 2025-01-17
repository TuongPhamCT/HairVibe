import 'package:hairvibe/Const/app_config.dart';
import 'package:hairvibe/Models/rating_repo.dart';
import 'package:hairvibe/Models/user_model.dart';
import 'package:hairvibe/Models/user_repo.dart';
import 'package:hairvibe/Models/work_session_model.dart';
import 'package:hairvibe/Models/work_session_repo.dart';
import 'package:hairvibe/Singletons/barber_singleton.dart';
import 'package:hairvibe/Singletons/booking_singleton.dart';

import '../Contract/barber_screen_contract.dart';

class BarberScreenPresenter {
  final BarberScreenContract _view;
  BarberScreenPresenter(this._view);

  final UserRepository _userRepo = UserRepository(AppConfig.dbType);
  final RatingRepository _ratingRepo = RatingRepository(AppConfig.dbType);
  final WorkSessionRepository _workSessionRepo = WorkSessionRepository(AppConfig.dbType);
  final BarberSingleton _barberSingleton = BarberSingleton.getInstance();
  final BookingSingleton _bookingSingleton = BookingSingleton.getInstance();

  List<UserModel> barberList = [];
  Map<String, double> ratings = {};
  Map<String, List<WorkSessionModel>> workSessions = {};

  Future<void> getData() async {
    barberList = await _userRepo.getAllBarbers();

    for (UserModel barber in barberList) {
      ratings[barber.userID!] = await _ratingRepo.calculateRatingOfBarber(barber.userID!);
      workSessions[barber.userID!] = await _workSessionRepo.getWorkSessionsByBarberId(barber.userID!);
    }
    _view.onLoadDataSucceed();
  }

  void handleBookBarberPressed(UserModel model) {
    _bookingSingleton.setCacheBarber(model);
    _view.onBookBarberPressed();
  }

  void handleDetailBarberPressed(UserModel model) {
    _barberSingleton.setBarber(model);
    _view.onDetailBarberPressed();
  }
}