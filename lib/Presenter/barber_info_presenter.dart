import 'package:hairvibe/Contract/detail_barber_contract.dart';
import 'package:hairvibe/Models/rating_repo.dart';
import 'package:hairvibe/Models/user_repo.dart';
import 'package:hairvibe/Singletons/barber_singleton.dart';

import '../Models/rating_model.dart';
import '../Models/user_model.dart';

class BarberInfoPresenter {
  final DetailBarberContract _view;
  BarberInfoPresenter(this._view);

  final BarberSingleton _singleton = BarberSingleton.getInstance();
  final RatingRepository _ratingRepo = RatingRepository();
  final UserRepository _userRepo = UserRepository();
  List<RatingModel> ratings = [];
  Map<String, UserModel> users = {};

  Future<void> getData() async {
    _view.onLoadDataSucceed();
    ratings =
        await _ratingRepo.getRatingsByBarberId(_singleton.barber!.userID!);
    for (RatingModel model in ratings) {
      users[model.userID!] = await _userRepo.getUserById(model.userID!);
    }
    _view.onLoadDataSucceed();
  }

  String getBarberAvatarUrl() {
    return _singleton.barber!.image!;
  }

  String getBarberName() {
    return _singleton.barber!.name!;
  }
}
