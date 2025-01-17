import 'package:hairvibe/Const/app_config.dart';
import 'package:hairvibe/Contract/rating_barber_contract.dart';
import 'package:hairvibe/Facades/notification_facade.dart';
import 'package:hairvibe/Models/rating_model.dart';
import 'package:hairvibe/Models/rating_repo.dart';
import 'package:hairvibe/Singletons/barber_singleton.dart';
import 'package:hairvibe/Singletons/user_singleton.dart';

import '../Models/user_model.dart';

class RatingBarberPresenter {
  final RatingBarberContract _view;
  RatingBarberPresenter(this._view);

  final RatingRepository _ratingRepository = RatingRepository(AppConfig.dbType);
  final NotificationFacade _notificationFacade = NotificationFacade();
  final BarberSingleton _barberSingleton = BarberSingleton.getInstance();

  Future<void> handleRating(String content, double rate) async {
    if (content.isEmpty) {
      _view.onRatingFailed("Please enter your review before submitting");
      return;
    }

    UserModel customer = UserSingleton.getInstance().currentUser!;
    String barberID = _barberSingleton.barber!.userID!;

    if (_barberSingleton.thisUserRating == null) {
      // Add new Review

      RatingModel ratingModel = RatingModel(
          userID: customer.userID,
          barberID: barberID,
          date: DateTime.now(),
          rate: rate,
          info: content
      );

      _view.onWaitingProgressBar();
      ratingModel.ratingID = await _ratingRepository.addRating(ratingModel);
      if (ratingModel.ratingID!.isEmpty) {
        _view.onPopContext();
        _view.onRatingFailed("Something was wrong. Please try again.");
        return;
      }

    } else {
      // Update Review

      RatingModel ratingModel = _barberSingleton.thisUserRating!;
      if (ratingModel.info == content && ratingModel.rate == rate) {
        _view.onRatingFailed("Nothing change");
        return;
      }

      ratingModel.info = content;
      ratingModel.rate = rate;

      _view.onWaitingProgressBar();
      bool result = await _ratingRepository.updateRating(ratingModel);
      if (!result) {
        _view.onPopContext();
        _view.onRatingFailed("Something was wrong. Please try again.");
        return;
      }
    }

    await _notificationFacade.createRatingBarberNotification(
        ratingValue: rate,
        customerName: customer.name!,
        barberID: barberID
    );
    // notify all subscribers about new rating change
    UserSingleton.getInstance().notifySubscribers();

    _view.onPopContext();
    _view.onRatingSucceeded();
  }

  void handleBack() {
    if (_barberSingleton.barber!.userType == UserType.ADMIN) {
      _barberSingleton.reset();
    }
    _view.onBack();
  }
}