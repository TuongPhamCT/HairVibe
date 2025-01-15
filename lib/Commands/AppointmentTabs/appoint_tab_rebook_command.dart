import 'package:hairvibe/Models/appointment_model.dart';
import 'package:hairvibe/Presenter/appointment_tab_presenter.dart';

import '../command_interface.dart';

class AppointTabRebookCommand implements CommandInterface {
  AppointmentTabPresenter? presenter;
  AppointmentModel? appointment;

  AppointTabRebookCommand({
    required this.presenter,
    required this.appointment
  });

  @override
  void execute() {
    presenter?.handleRebookPressed(appointment!);
  }
}