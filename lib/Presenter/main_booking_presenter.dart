import 'package:flutter/material.dart';
import 'package:hairvibe/Builders/ModelBuilder/appointment_model_builder.dart';
import 'package:hairvibe/Const/app_config.dart';
import 'package:hairvibe/Contract/main_booking_contract.dart';
import 'package:hairvibe/Facades/authenticator_facade.dart';
import 'package:hairvibe/Models/appointment_model.dart';
import 'package:hairvibe/Models/appointment_repo.dart';
import 'package:hairvibe/Models/leave_repo.dart';
import 'package:hairvibe/Models/rating_repo.dart';
import 'package:hairvibe/Models/service_model.dart';
import 'package:hairvibe/Models/service_repo.dart';
import 'package:hairvibe/Models/user_repo.dart';
import 'package:hairvibe/Models/work_session_model.dart';
import 'package:hairvibe/Models/work_session_repo.dart';
import 'package:hairvibe/Singletons/appointment_singleton.dart';
import 'package:hairvibe/Singletons/booking_singleton.dart';

import '../Models/leave_model.dart';
import '../Models/user_model.dart';
import '../Utility.dart';

class MainBookingPresenter {
  final MainBookingContract _view;
  MainBookingPresenter(this._view);

  final AuthenticatorFacade _auth = AuthenticatorFacade();
  final BookingSingleton _bookingSingleton = BookingSingleton.getInstance();
  final AppointmentSingleton _appointmentSingleton = AppointmentSingleton.getInstance();

  final ServiceRepository _serviceRepo = ServiceRepository(AppConfig.dbType);
  final UserRepository _userRepo = UserRepository(AppConfig.dbType);
  final WorkSessionRepository _workSessionRepo = WorkSessionRepository(AppConfig.dbType);
  final LeaveRepository _leaveRepo = LeaveRepository(AppConfig.dbType);
  final AppointmentRepository _appointmentRepo = AppointmentRepository(AppConfig.dbType);
  final RatingRepository _ratingRepo = RatingRepository(AppConfig.dbType);

  final TimeOfDay workSessionStart = const TimeOfDay(hour: 9, minute: 0);
  final TimeOfDay workSessionEnd = const TimeOfDay(hour: 18, minute: 0);
  final Duration timeStep = const Duration(minutes: 30);

  List<Map<String, dynamic>> services = [];

  List<UserModel> barbers = [];
  Map<String, double> ratings = {};
  List<int> currentBarberWorkSessions = [];
  List<LeaveModel> currentBarberLeaves = [];
  List<AppointmentModel> currentBarberAppointments = [];
  List<dynamic> times = [];
  int cacheTimeCheckIndex = -1;

  UserModel? selectedBarber;
  int selectedBarberIndex = 0;
  DateTime? selectedDate;
  DateTime? focusedDate;
  int totalCost = 0;
  int totalDuration = 0;

  Future<void> getData() async {
    List<ServiceModel> serviceList = await _serviceRepo.getAllServices();

    ServiceModel? storedService = _bookingSingleton.selectedService;

    services = List.generate(
      serviceList.length,
      (index) => {
        'serviceModel': serviceList[index],
        'isChecked': storedService != null && storedService.serviceID == serviceList[index].serviceID,
      },
    );

    if (storedService == null) {
      services.first['isChecked'] = true;
      totalDuration += serviceList.first.duration!;
      totalCost += serviceList.first.price!;
    } else {
      totalDuration += storedService.duration!;
      totalCost += storedService.price!;
    }

    barbers = await _userRepo.getAllBarbers();
    UserModel? storedBarber = _bookingSingleton.selectedBarber;

    selectedBarber = barbers.first;
    selectedBarberIndex = 0;
    for (UserModel barber in barbers) {
      if (storedBarber != null && barber.userID == storedBarber.userID) {
        selectedBarber = barber;
        break;
      }
      selectedBarberIndex ++;
    }

    for (UserModel barber in barbers) {
      ratings[barber.userID!] = await _ratingRepo.calculateRatingOfBarber(barber.userID!);
    }
    selectedDate = Utility.getTodayDate();
    focusedDate = Utility.getTodayDate();
    currentBarberAppointments = await _appointmentRepo.getAppointmentsByUserIdAndDate(selectedBarber!.userID!, selectedDate!);
    currentBarberLeaves = await _leaveRepo.getLeavesByBarberId(selectedBarber!.userID!);
    await _loadWorkSessions();
    _generateTimeList();
    _view.onLoadDataSucceed();
  }

  String getTotalCost() {
    return Utility.formatCurrency(totalCost);
  }

  void handleSelectService(ServiceModel service, int index, bool result) {
    if (result) {
      totalCost += service.price!;
      totalDuration += service.duration!;
    } else {
      totalCost -= service.price!;
      totalDuration -= service.duration!;
    }
    services[index]['isChecked'] = result;
    _generateTimeList();
    _view.onSelectService();
  }

  Future<void> handleSelectBarber(UserModel barber, int index) async {
    _view.onWaitingProgressBar();
    selectedBarber = barber;
    selectedBarberIndex = index;
    currentBarberAppointments = await _appointmentRepo.getAppointmentsByBarberIdAndDate(barber.userID!, selectedDate!);
    currentBarberLeaves = await _leaveRepo.getLeavesByBarberId(barber.userID!);
    await _loadWorkSessions();
    _generateTimeList();
    _view.onPopContext();
    _view.onSelectBarber(index);
  }

  Future<void> handleSelectDate(DateTime selectedDate, DateTime focusedDate) async {
    _view.onWaitingProgressBar();
    this.selectedDate = selectedDate;
    this.focusedDate = focusedDate;
    cacheTimeCheckIndex = -1;
    currentBarberAppointments = await _appointmentRepo.getAppointmentsByBarberIdAndDate(selectedBarber!.userID!, selectedDate);
    _generateTimeList();
    _view.onPopContext();
    _view.onSelectDate();
  }

  void handleSelectTime(int index) {
    if (cacheTimeCheckIndex >= 0) {
      if (cacheTimeCheckIndex != index) {
        times[cacheTimeCheckIndex]['isChecked'] = false;
        times[index]['isChecked'] = true;
        cacheTimeCheckIndex = index;
      }
    } else {
      times[index]['isChecked'] = true;
      cacheTimeCheckIndex = index;
    }

    _view.onSelectTime();
  }

  Future<void> handleNextPressed() async {
    List<ServiceModel> selectedServices = [];
    for (Map<String, dynamic> service in services) {
      if (service['isChecked']) {
        selectedServices.add(service['serviceModel']);
      }
    }

    if (selectedServices.isEmpty) {
      _view.onValidatingFailed("Please select a service for your appointment");
      return;
    }

    TimeOfDay time = const TimeOfDay(hour: 0, minute: 0);
    bool isSelectedTime = false;
    for (Map<String, dynamic> timeStamp in times) {
      if (timeStamp['isChecked']) {
        isSelectedTime = true;
        time = timeStamp['time'];
        break;
      }
    }

    if (isSelectedTime == false) {
      _view.onValidatingFailed("Please select a time for your appointment");
      return;
    }

    _bookingSingleton.reset();
    AppointmentModelBuilder builder = _bookingSingleton.builder;
    builder.setBarberID(selectedBarber!.userID!);
    builder.setCustomerID(_auth.userId!);
    builder.setStatus(AppointmentStatus.UPCOMING);
    builder.setDate(Utility.getDateTimeFromDateAndTimeOfDay(selectedDate!, time));
    builder.addServices(selectedServices);

    _appointmentSingleton.setAppointment(builder.build());

    _bookingSingleton.setBarberID(selectedBarber!.userID!);
    _bookingSingleton.setCustomerID(_auth.userId!);

    _view.onWaitingProgressBar();
    await _appointmentSingleton.loadViewBookingData();
    _view.onPopContext();

    _view.onNext();
  }

  void handleBack() {
    _bookingSingleton.resetCache();
  }

  Future<void> _loadWorkSessions() async {
    List<WorkSessionModel> workSessions = await _workSessionRepo.getWorkSessionsByBarberId(selectedBarber!.userID!);
    currentBarberWorkSessions.clear();
    for (WorkSessionModel item in workSessions) {
      currentBarberWorkSessions.add(item.day!);
    }
  }

  Duration _getTotalDuration() {
    return Duration(hours: totalDuration ~/ 60, minutes: totalDuration % 60);
  }

  void _generateTimeList() {
    if (totalDuration == 0 || currentBarberWorkSessions.contains(selectedDate!.weekday) == false) {
      times.clear();
      return;
    }

    List<TimeOfDay> timeList = [];

    int start = Utility.convertTimeOfDayToInt(workSessionStart);
    int end = Utility.convertTimeOfDayToInt(workSessionEnd) - totalDuration;

    for (int i = start ; i <= end ; i += timeStep.inMinutes) {
      TimeOfDay timeStamp = Utility.convertIntToTimeOfDay(i);
      bool isConflicted = false;
      // Check if this timestamp conflict with barber appointments
      for (AppointmentModel appointment in currentBarberAppointments) {
        TimeOfDay appointmentStart = Utility.getTimeOfDayFromDateTime(appointment.date!);
        if (Utility.isScheduleConflicted(appointmentStart, appointment.getDuration(), timeStamp, _getTotalDuration())) {
          isConflicted = true;
          break;
        }
      }
      if (!isConflicted) {
        timeList.add(timeStamp);
      }
    }

    times = List.generate(
        timeList.length,
        (index) => {
          'time': timeList[index],
          'isChecked': false
        }
    );
  }
}