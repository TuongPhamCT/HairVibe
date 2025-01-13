import 'package:hairvibe/Contract/admin_appointment_contract.dart';
import 'package:hairvibe/Models/appointment_model.dart';
import 'package:hairvibe/Models/appointment_repo.dart';
import 'package:hairvibe/Singletons/appointment_singleton.dart';

class AdminAppointmentPagePresenter {
  final AdminAppointmentPageContract _view;
  AdminAppointmentPagePresenter(this._view);

  final AppointmentSingleton _appointmentSingleton = AppointmentSingleton.getInstance();
  final AppointmentRepository _appointmentRepo = AppointmentRepository();

  List<AppointmentModel> appointments = [];
  DateTime selectedDate = DateTime.now();

  Future<void> getData() async {
    appointments = await _appointmentRepo.getAppointmentsByDate(selectedDate);
    _view.onLoadDataSucceeded();
  }

  Future<void> handleChangeDate(DateTime date) async {
    _view.onSelectDate();
    selectedDate = date;
    appointments = await _appointmentRepo.getAppointmentsByDate(selectedDate);
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