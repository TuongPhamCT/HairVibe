import 'package:hairvibe/Models/rating_repo.dart';
import 'package:hairvibe/Models/user_model.dart';
import 'package:hairvibe/Models/user_repo.dart';

import '../Contract/barber_screen_contract.dart';

class BarberScreenPresenter {
  final BarberScreenContract _view;
  BarberScreenPresenter(this._view);

  final UserRepository _userRepo = UserRepository();
  final RatingRepository _ratingRepo = RatingRepository();

  List<UserModel> barberList = [];
  Map<String, double> ratings = {};

  Future<void> getData() async {
    barberList = await _userRepo.getAllBarbers();

    for (UserModel barber in barberList) {
      ratings[barber.userID!] = await _ratingRepo.calculateRatingOfBarber(barber.userID!);
    }
    _view.onLoadDataSucceed();
  }

  void handleBarberPressed(UserModel model) {
    _view.onBarberPressed();
  }
}