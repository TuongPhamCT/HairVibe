import 'package:hairvibe/Contract/admin_comment_page_contract.dart';
import 'package:hairvibe/Models/rating_repo.dart';
import 'package:hairvibe/Models/service_repo.dart';
import 'package:hairvibe/Models/user_repo.dart';
import 'package:hairvibe/Singletons/user_singleton.dart';

import '../Models/rating_model.dart';
import '../Models/service_model.dart';
import '../Models/user_model.dart';

class AdminCommentPagePresenter {
  final AdminCommentPageContract _view;
  AdminCommentPagePresenter(this._view);

  final UserSingleton _userSingleton = UserSingleton.getInstance();
  final RatingRepository _ratingRepo = RatingRepository();
  final UserRepository _userRepo = UserRepository();
  final ServiceRepository _serviceRepo = ServiceRepository();

  List<RatingModel> ratings = [];
  Map<String, UserModel> users = {};
  List<ServiceModel> services = [];

  Future<void> getData() async {
    ratings = await _ratingRepo.getRatingsByBarberId(_userSingleton.currentUser!.userID!);
    for (RatingModel model in ratings) {
      users[model.userID!] = await _userRepo.getUserById(model.userID!);
    }
    services = await _serviceRepo.getAllServices();
    _view.onLoadDataSucceeded();
  }

  String getUserName() {
    return _userSingleton.currentUser!.name ?? "";
  }

  Future<void> handleDeleteService(ServiceModel service) async {
    _view.onWaitingProgressBar();
    await _serviceRepo.deleteServiceById(service.serviceID!);
    services.remove(service);
    _view.onPopContext();
    _view.onLoadDataSucceeded();
  }

}