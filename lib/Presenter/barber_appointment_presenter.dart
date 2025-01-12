import 'package:hairvibe/Contract/barber_appointment_contract.dart';
import 'package:hairvibe/Models/appointment_model.dart';
import 'package:hairvibe/Models/appointment_repo.dart';
import 'package:hairvibe/Singletons/appointment_singleton.dart';

class BarberAppointmentPagePresenter {
  final BarberAppointmentPageContract _view;
  BarberAppointmentPagePresenter(this._view);

  final AppointmentSingleton _appointmentSingleton =
      AppointmentSingleton.getInstance();
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
    _view.onWaitingProgressBar();
    appointments = await _appointmentRepo.getAppointmentsByDate(selectedDate);
    _view.onPopContext();
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
