import 'package:hairvibe/Contract/detail_barber_contract.dart';
import 'package:hairvibe/Facades/image_storage_facade.dart';
import 'package:hairvibe/Models/rating_repo.dart';
import 'package:hairvibe/Models/user_repo.dart';
import 'package:hairvibe/Models/work_session_model.dart';
import 'package:hairvibe/Models/work_session_repo.dart';
import 'package:hairvibe/Singletons/barber_singleton.dart';
import 'package:hairvibe/Singletons/user_singleton.dart';
import 'package:hairvibe/Utility.dart';

import '../Models/rating_model.dart';
import '../Models/user_model.dart';

class DetailBarberPresenter {
  final DetailBarberContract _view;
  DetailBarberPresenter(this._view);

  final BarberSingleton _barberSingleton = BarberSingleton.getInstance();
  final UserSingleton _userSingleton = UserSingleton.getInstance();
  final RatingRepository _ratingRepo = RatingRepository();
  final UserRepository _userRepo = UserRepository();
  final WorkSessionRepository _workSessionRepository = WorkSessionRepository();
  final ImageStorageFacade _imageStorageFacade = ImageStorageFacade();
  List<RatingModel> ratings = [];
  Map<String, UserModel> users = {};
  List<WorkSessionModel> workSessions = [];

  Future<void> getData() async {
    if (_userSingleton.currentUserIsBarber()) {
      _barberSingleton.reset();
    }

    if (_userSingleton.currentUserIsCustomer() == false && _barberSingleton.barber == null) {
      _barberSingleton.setBarber(_userSingleton.currentUser!);
      if (_userSingleton.currentUserIsBarber()) {
        workSessions = await _workSessionRepository.getWorkSessionsByBarberId(_barberSingleton.barber!.userID!);
        if (workSessions.isNotEmpty) {
          workSessions.sort((element1, element2) => element1.day! - element2.day!);
        }
      }
    }
    ratings = await _ratingRepo.getRatingsByBarberId(_barberSingleton.barber!.userID!);
    for (RatingModel model in ratings) {
      users[model.userID!] = await _userRepo.getUserById(model.userID!);
      if (_userSingleton.currentUserIsCustomer()
          && model.userID == _userSingleton.currentUser!.userID!) {
        _barberSingleton.setThisUserRating(model);
      }
    }
    _view.onLoadDataSucceed();
  }

  String getBarberAvatarUrl() {
    return _barberSingleton.barber!.image!;
  }

  String getBarberName() {
    return _barberSingleton.barber!.name!;
  }

  List<String> getBarberImages() {
    return _barberSingleton.getBarberImageUrls();
  }

  List<Map<String, String>> getWorkingHours() {
    List<Map<String, String>> workingHours = [];

    for (WorkSessionModel model in workSessions) {
      Map<String, String> element = {
        'day': Utility.getDayOfWeekText(model.day!),
        'hours': '9am - 6pm',
      };
      workingHours.add(element);
    }

    return workingHours;
  }

  List<bool> getWorkSessionToggles() {
    List<bool> toggles = List.generate(7, (index) => false);
    for (WorkSessionModel model in workSessions) {
      toggles[model.day! - 1] = true;
    }
    return toggles;
  }

  Future<void> updateWorkSessions(List<bool> workSessionToggles) async {
    if (_userSingleton.currentUserIsBarber() == false) {
      return;
    }
    UserModel user = _userSingleton.currentUser!;
    for (WorkSessionModel model in workSessions) {
      await _workSessionRepository.deleteWorkSessionById(user.userID!, model.workSessionID!);
    }
    workSessions.clear();

    for (int i = 0; i < 7; i++) {
      if (workSessionToggles[i]) {
        WorkSessionModel model = WorkSessionModel(
          barberID: user.userID,
          day: i + 1
        );
        model.workSessionID = await _workSessionRepository.addWorkSessionToFirestore(model);
        workSessions.add(model);
      }
    }
    _view.onLoadDataSucceed();
  }

  Future<void> deletePhoto(String url) async {

    UserModel model = _userSingleton.currentUser!;
    model.removeBarberImage(url);

    _barberSingleton.barber = model;

    _view.onWaitingProgressBar();
    await _userRepo.updateUser(model);
    _view.onPopContext();
    _view.onLoadDataSucceed();
  }

  Future<void> addPhoto() async {
    _view.onWaitingProgressBar();
    String? path = await _imageStorageFacade.pickAndUploadImage(StorageFolderNames.BARBER_IMAGES);

    if (path != null) {
      UserModel model = _userSingleton.currentUser!;
      model.addBarberImage(path);

      _barberSingleton.barber = model;

      await _userRepo.updateUser(model);
      _view.onPopContext();
      _view.onLoadDataSucceed();
      return;
    }
    _view.onPopContext();
  }

  void handleBack() {
    _barberSingleton.reset();
    _view.onBack();
  }
}
