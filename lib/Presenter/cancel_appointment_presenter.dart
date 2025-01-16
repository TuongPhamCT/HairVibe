import 'package:hairvibe/Builders/ModelBuilder/appointment_model_builder.dart';
import 'package:hairvibe/Contract/cancel_appointment_contract.dart';
import 'package:hairvibe/Facades/notification_facade.dart';
import 'package:hairvibe/Models/appointment_model.dart';
import 'package:hairvibe/Models/appointment_repo.dart';
import 'package:hairvibe/Singletons/appointment_singleton.dart';

class CancelAppointmentPagePresenter {
  final CancelAppointmentPageContract _view;
  CancelAppointmentPagePresenter(this._view);

  final AppointmentSingleton _singleton = AppointmentSingleton.getInstance();
  final AppointmentModelBuilder _builder = AppointmentModelBuilder();
  final AppointmentRepository _repo = AppointmentRepository();
  final NotificationFacade _notificationFacade = NotificationFacade();

  Future<void> handleConfirmPressed(String reason) async {
    _view.onWaitingProgressBar();

    if (reason == "") {
      _view.onPopContext();
      _view.onConfirmFailed("Please provide a reason for canceling the appointment");
      return;
    }

    _builder.setAppointment(_singleton.appointment!);
    _builder.setStatus(AppointmentStatus.CANCELLED);
    _builder.setCancelReason(reason);
    await _repo.updateAppointment(_builder.build());
    await _notificationFacade.createCancelAppointmentNotification(
        appointment: _singleton.appointment!,
        sendToBarber: true,
        sendToCustomer: false,
        reason: reason
    );

    _view.onPopContext();
    _view.onConfirmSucceed();
  }
}