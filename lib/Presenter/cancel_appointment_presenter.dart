import 'package:hairvibe/Builders/ModelBuilder/appointment_model_builder.dart';
import 'package:hairvibe/Contract/cancel_appointment_contract.dart';
import 'package:hairvibe/Models/appointment_model.dart';
import 'package:hairvibe/Models/appointment_repo.dart';
import 'package:hairvibe/Singletons/appointment_singleton.dart';

class CancelAppointmentPagePresenter {
  final CancelAppointmentPageContract _view;
  CancelAppointmentPagePresenter(this._view);

  final AppointmentSingleton _singleton = AppointmentSingleton.getInstance();
  final AppointmentModelBuilder _builder = AppointmentModelBuilder();
  final AppointmentRepository _repo = AppointmentRepository();

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

    _view.onPopContext();
    _view.onConfirmSucceed();
  }
}