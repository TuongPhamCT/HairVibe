import 'package:hairvibe/Const/app_config.dart';
import 'package:hairvibe/Contract/account_page_contract.dart';
import 'package:hairvibe/Facades/authenticator_facade.dart';
import 'package:hairvibe/Models/rating_repo.dart';
import 'package:hairvibe/Models/user_repo.dart';

import '../Models/rating_model.dart';
import '../Models/user_model.dart';
import '../Singletons/barber_singleton.dart';
import '../Singletons/user_singleton.dart';

class AccountPagePresenter {
  final AccountPageContract _view;
  AccountPagePresenter(this._view);

  final UserSingleton _userSingleton = UserSingleton.getInstance();
  final BarberSingleton _barberSingleton = BarberSingleton.getInstance();
  final UserRepository _userRepository = UserRepository(AppConfig.dbType);
  final RatingRepository _ratingRepository = RatingRepository(AppConfig.dbType);
  final AuthenticatorFacade _auth = AuthenticatorFacade();

  Future<void> handleReviewAdmin() async {
    _view.onWaitingProgressBar();
    List<UserModel> admins = await _userRepository.getAllAdmins();
    if (admins.isEmpty) {
      return;
    }
    UserModel admin = admins.first;
    _barberSingleton.setBarber(admin);
    List<RatingModel> ratings = await _ratingRepository.getRatingsByBarberId(admin.userID!);

    for (RatingModel rating in ratings) {
      if (rating.userID == _userSingleton.currentUser!.userID) {
        _barberSingleton.thisUserRating = rating;
        break;
      }
    }

    _view.onPopContext();
    _view.toReviewAdmin();
  }

  Future<void> handleLogOut() async {
    _view.onWaitingProgressBar();
    await _auth.signOut();
    await _userSingleton.handleActionsAfterLogOut();
    _view.onPopContext();
    _view.onLogOut();
  }
}