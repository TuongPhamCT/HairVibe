import 'package:hairvibe/Contract/admin_appointment_contract.dart';
import 'package:hairvibe/Facades/authenticator_facade.dart';
import 'package:hairvibe/Models/appointment_model.dart';
import 'package:hairvibe/Models/appointment_repo.dart';
import 'package:hairvibe/Singletons/appointment_singleton.dart';
import 'package:hairvibe/Singletons/user_singleton.dart';

class AdminAppointmentPagePresenter {
  final AdminAppointmentPageContract _view;
  AdminAppointmentPagePresenter(this._view);

  final AppointmentSingleton _appointmentSingleton = AppointmentSingleton.getInstance();
  final AppointmentRepository _appointmentRepo = AppointmentRepository();
  final AuthenticatorFacade _auth = AuthenticatorFacade();

  List<AppointmentModel> appointments = [];
  DateTime selectedDate = DateTime.now();

  bool get isAdmin => UserSingleton.getInstance().currentUserIsAdmin();

  Future<void> getData() async {
    if (isAdmin) {
      appointments = await _appointmentRepo.getAppointmentsByDate(selectedDate);
    } else {
      appointments = await _appointmentRepo.getAppointmentsByBarberIdAndDate(_auth.userId!, selectedDate);
    }

    _view.onLoadDataSucceeded();
  }

  Future<void> handleChangeDate(DateTime date) async {
    _view.onSelectDate();
    selectedDate = date;
    if (isAdmin) {
      appointments = await _appointmentRepo.getAppointmentsByDate(selectedDate);
    } else {
      appointments = await _appointmentRepo.getAppointmentsByBarberIdAndDate(_auth.userId!, selectedDate);
    }
    _view.onLoadDataSucceeded();
  }

  Future<void> handleSelectAppointment(AppointmentModel appointment) async {
    _view.onWaitingProgressBar();
    _appointmentSingleton.setAppointment(appointment);
    await _appointmentSingleton.loadViewBookingData();
    _view.onPopContext();
    _view.onSelectAppointment();
  }
}