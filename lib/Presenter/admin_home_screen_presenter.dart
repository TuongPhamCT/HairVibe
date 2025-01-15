import 'package:hairvibe/Contract/admin_home_screen_contract.dart';
import 'package:hairvibe/Facades/authenticator_facade.dart';
import 'package:hairvibe/Models/appointment_model.dart';
import 'package:hairvibe/Models/appointment_repo.dart';
import 'package:hairvibe/Models/service_repo.dart';
import 'package:hairvibe/Models/user_repo.dart';
import 'package:hairvibe/Utility.dart';

class AdminHomeScreenPresenter {
  final AdminHomeScreenContract _view;
  AdminHomeScreenPresenter(this._view);

  final UserRepository _userRepo = UserRepository();
  final ServiceRepository _serviceRepo = ServiceRepository();
  final AppointmentRepository _appointmentRepo = AppointmentRepository();
  final AuthenticatorFacade _auth = AuthenticatorFacade();

  int servicesCount = 0;
  int todayAppointmentCount = 0;
  int customerCount = 0;
  int barberCount = 0;
  final List<DateTime> dateOfWeeks = Utility.getCurrentWeekDates();
  static const List<String> dayOfWeeks = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"];
  Map<String, List<AppointmentModel>> appointments = {};

  bool isAdmin = true;

  Future<void> getData() async {
    if (isAdmin) {
      servicesCount = await _serviceRepo.getServicesCount();
      customerCount = await _userRepo.getCustomersCount();
      barberCount = await _userRepo.getBarbersCount();

      for (int i = 0; i < 7; i++) {
        List<AppointmentModel> appointmentList = await _appointmentRepo.getAppointmentsByDate(dateOfWeeks[i]);
        appointments[dayOfWeeks[i]] = appointmentList;

        if (Utility.isSameDate(DateTime.now(), dateOfWeeks[i])) {
          todayAppointmentCount = appointmentList
                                    .where((element)
                                      => element.status != AppointmentStatus.CANCELLED)
                                    .toList()
                                    .length;
        }
      }
    } else {
      for (int i = 0; i < 7; i++) {
        List<AppointmentModel> appointmentList = await _appointmentRepo.getAppointmentsByBarberIdAndDate(_auth.userId!, dateOfWeeks[i]);
        appointments[dayOfWeeks[i]] = appointmentList;

        if (Utility.isSameDate(DateTime.now(), dateOfWeeks[i])) {
          todayAppointmentCount = appointmentList
              .where((element)
          => element.status != AppointmentStatus.CANCELLED)
              .toList()
              .length;

        }
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
            completedCount ++;
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