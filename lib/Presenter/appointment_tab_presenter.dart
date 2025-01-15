import 'package:hairvibe/Contract/appointment_tab_contract.dart';
import 'package:hairvibe/Models/appointment_model.dart';
import 'package:hairvibe/Models/user_model.dart';
import 'package:hairvibe/Models/user_repo.dart';
import 'package:hairvibe/Singletons/appointment_singleton.dart';

import '../Facades/authenticator_facade.dart';
import '../Models/appointment_repo.dart';

class AppointmentTabPresenter {
  final AppointmentTabContract _view;
  AppointmentTabPresenter(this._view);
  final AppointmentRepository _appointRepo = AppointmentRepository();
  final UserRepository _userRepo = UserRepository();
  final AuthenticatorFacade _auth = AuthenticatorFacade();
  final AppointmentSingleton _singleton = AppointmentSingleton.getInstance();

  List<AppointmentModel> cancelledAppointments = [];
  List<AppointmentModel> completedAppointments = [];
  List<AppointmentModel> upcomingAppointments = [];
  List<UserModel> barbers = [];

  Future<void> getData() async {
    cancelledAppointments = await _appointRepo.getAllCancelledAppointments(_auth.userId!);
    completedAppointments = await _appointRepo.getAllCompletedAppointments(_auth.userId!);
    upcomingAppointments = await _appointRepo.getAllUpcomingAppointments(_auth.userId!);
    barbers = await _userRepo.getAllBarbers();
    _view.onLoadDataSucceed();
  }

  UserModel? findBarberByID(String barberID) {
    UserModel? result;
    for (UserModel model in barbers) {
      if (model.userID == barberID) {
        return model;
      }
    }
    return result;
  }

  Future<void> handleViewReceiptPressed(AppointmentModel model) async {
    _view.onWaitingProgressBar();
    _singleton.setAppointment(model);
    await _singleton.loadViewBookingData();
    _view.onPopContext();
    _view.onViewReceiptPressed();
  }

  void handleRebookPressed(AppointmentModel model) {
    _view.onRebookPressed();
  }

  void handleCancelPressed(AppointmentModel model) {
    _singleton.setAppointment(model);
    _view.onCancelPressed();
  }
}