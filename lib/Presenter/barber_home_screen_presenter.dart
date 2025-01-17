import 'package:hairvibe/Const/app_config.dart';
import 'package:hairvibe/Contract/barber_home_screen_contract.dart';
import 'package:hairvibe/Models/appointment_model.dart';
import 'package:hairvibe/Models/appointment_repo.dart';
import 'package:hairvibe/Models/service_repo.dart';
import 'package:hairvibe/Models/user_repo.dart';
import 'package:hairvibe/Utility.dart';

class BarberHomeScreenPresenter {
  final BarberHomeScreenContract _view;
  BarberHomeScreenPresenter(this._view);

  final UserRepository _userRepo = UserRepository(AppConfig.dbType);
  final ServiceRepository _serviceRepo = ServiceRepository(AppConfig.dbType);
  final AppointmentRepository _appointmentRepo = AppointmentRepository(AppConfig.dbType);

  int servicesCount = 0;
  int todayAppointmentCount = 0;
  int customerCount = 0;
  //int barberCount = 0;
  final List<DateTime> dateOfWeeks = Utility.getCurrentWeekDates();
  static const List<String> dayOfWeeks = [
    "Mo",
    "Tu",
    "We",
    "Th",
    "Fr",
    "Sa",
    "Su"
  ];
  Map<String, List<AppointmentModel>> appointments = {};

  Future<void> getData() async {
    servicesCount = await _serviceRepo.getServicesCount();
    customerCount = await _userRepo.getCustomersCount();
    //barberCount = await _userRepo.getCustomersCount();

    for (int i = 0; i < 7; i++) {
      List<AppointmentModel> appointmentList =
          await _appointmentRepo.getAppointmentsByDate(dateOfWeeks[i]);
      appointments[dayOfWeeks[i]] = appointmentList;

      if (Utility.isSameDate(DateTime.now(), dateOfWeeks[i])) {
        todayAppointmentCount = appointmentList.length;
      }
    }

    _view.onLoadDataSucceeded();
  }

  int getCompletedAppointmentsCount({required String dayOfWeeks}) {
    if (appointments.containsKey(dayOfWeeks)) {
      List<AppointmentModel>? modelList = appointments[dayOfWeeks];
      if (modelList != null) {
        int completedCount = 0;
        for (AppointmentModel model in modelList) {
          if (model.status == AppointmentStatus.COMPLETED) {
            completedCount++;
          }
        }
        return completedCount;
      }
    }
    return 0;
  }

  double getBookedHourCount({required String dayOfWeeks}) {
    if (appointments.containsKey(dayOfWeeks)) {
      List<AppointmentModel>? modelList = appointments[dayOfWeeks];
      if (modelList != null) {
        int secondsCount = 0;
        for (AppointmentModel model in modelList) {
          if (model.status != AppointmentStatus.CANCELLED) {
            secondsCount += model.getDuration().inSeconds;
          }
        }
        return secondsCount / 3600;
      }
    }
    return 0;
  }

  double getTotalBookedHoursCount() {
    double hours = 0;
    for (String day in dayOfWeeks) {
      hours += getBookedHourCount(dayOfWeeks: day);
    }
    return hours;
  }

  int getTotalCompletedAppointmentsCount() {
    int hours = 0;
    for (String day in dayOfWeeks) {
      hours += getCompletedAppointmentsCount(dayOfWeeks: day);
    }
    return hours;
  }
}
