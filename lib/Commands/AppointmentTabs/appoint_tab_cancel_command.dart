import '../../Models/appointment_model.dart';
import '../../Presenter/appointment_tab_presenter.dart';
import '../command_interface.dart';

class AppointTabCancelCommand implements CommandInterface {
  AppointmentTabPresenter? presenter;
  AppointmentModel? appointment;

  AppointTabCancelCommand({
    required this.presenter,
    required this.appointment
  });

  @override
  void execute() {
    presenter?.handleCancelPressed(appointment!);
  }
}