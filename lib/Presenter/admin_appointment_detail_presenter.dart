import 'package:hairvibe/Const/app_config.dart';
import 'package:hairvibe/Contract/admin_appointment_detail_contract.dart';
import 'package:hairvibe/Facades/notification_facade.dart';
import 'package:hairvibe/Models/appointment_model.dart';
import 'package:hairvibe/Models/appointment_repo.dart';
import 'package:hairvibe/Singletons/appointment_singleton.dart';
import 'package:hairvibe/Singletons/user_singleton.dart';

class AdminAppointmentDetailPagePresenter {
  final AdminAppointmentDetailPageContract _view;
  AdminAppointmentDetailPagePresenter(this._view);

  final AppointmentSingleton _appointmentSingleton = AppointmentSingleton.getInstance();
  final UserSingleton _userSingleton = UserSingleton.getInstance();
  final AppointmentRepository _appointmentRepo = AppointmentRepository(AppConfig.dbType);
  final NotificationFacade _notificationFacade = NotificationFacade();

  void handleCancelButtonPressed() {
    _view.onCancelAppointment();
  }

  void handleCancelAppointment() {
    try {
      AppointmentModel targetAppointment = _appointmentSingleton.appointment!;
      targetAppointment.status = AppointmentStatus.CANCELLED;
      _appointmentRepo.updateAppointment(targetAppointment);
      _notificationFacade.createCancelAppointmentNotification(
          appointment: targetAppointment,
          sendToBarber: true,
          sendToCustomer: true
      );
      _userSingleton.notifySubscribers();
      _view.onCancelAppointmentSucceeded();
    } catch (e) {
      print(e);
      _view.onCancelAppointmentFailed();
    }
  }

  void handleBack() {
    _appointmentSingleton.reset();
    _view.onBack();
  }

  void handleCompleteButtonPressed() {
    _view.onCompleteAppointment();
  }

  void handleCompleteAppointment() {
    try {
      AppointmentModel targetAppointment = _appointmentSingleton.appointment!;
      targetAppointment.status = AppointmentStatus.COMPLETED;
      _appointmentRepo.updateAppointment(targetAppointment);
      _notificationFacade.createCompleteAppointmentNotification(
          appointment: targetAppointment,
      );
      _userSingleton.notifySubscribers();
      _view.onCompleteAppointmentSucceeded();
    } catch (e) {
      print(e);
      _view.onCompleteAppointmentFailed();
    }
  }
}