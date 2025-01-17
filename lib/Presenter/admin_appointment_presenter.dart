import 'package:hairvibe/Const/app_config.dart';
import 'package:hairvibe/Contract/admin_appointment_contract.dart';
import 'package:hairvibe/Facades/authenticator_facade.dart';
import 'package:hairvibe/Models/appointment_model.dart';
import 'package:hairvibe/Models/appointment_repo.dart';
import 'package:hairvibe/Models/user_repo.dart';
import 'package:hairvibe/Singletons/appointment_singleton.dart';
import 'package:hairvibe/Singletons/user_singleton.dart';

import '../Models/user_model.dart';

class AdminAppointmentPagePresenter {
  final AdminAppointmentPageContract _view;
  AdminAppointmentPagePresenter(this._view);

  final AppointmentSingleton _appointmentSingleton = AppointmentSingleton.getInstance();
  final AppointmentRepository _appointmentRepo = AppointmentRepository(AppConfig.dbType);
  final UserRepository _userRepo = UserRepository(AppConfig.dbType);
  final AuthenticatorFacade _auth = AuthenticatorFacade();

  Map<String, String> customerNames = {};
  List<AppointmentModel> appointments = [];
  DateTime selectedDate = DateTime.now();

  bool get isAdmin => UserSingleton.getInstance().currentUserIsAdmin();

  Future<void> getData() async {
    await loadAppointments();
    _view.onLoadDataSucceeded();
  }

  Future<void> handleChangeDate(DateTime date) async {
    _view.onSelectDate();
    selectedDate = date;
    await loadAppointments();
    _view.onLoadDataSucceeded();
  }

  Future<void> handleSelectAppointment(AppointmentModel appointment) async {
    _view.onWaitingProgressBar();
    _appointmentSingleton.setAppointment(appointment);
    await _appointmentSingleton.loadViewBookingData();
    _view.onPopContext();
    _view.onSelectAppointment();
  }

  Future<void> loadAppointments() async {
    if (isAdmin) {
      appointments = await _appointmentRepo.getActiveAppointmentsByDate(selectedDate);
    } else {
      appointments = await _appointmentRepo.getActiveAppointmentsByBarberIdAndDate(_auth.userId!, selectedDate);
    }
    for (AppointmentModel model in appointments) {
      if (customerNames.containsKey(model.customerID) == false) {
        UserModel user = await _userRepo.getUserById(model.customerID!);
        customerNames[model.customerID!] = user.name!;
      }
    }
  }
}