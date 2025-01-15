import '../../Models/appointment_model.dart';
import '../../Presenter/appointment_tab_presenter.dart';
import '../command_interface.dart';

class AppointTabViewCommand implements CommandInterface {
  AppointmentTabPresenter? presenter;
  AppointmentModel? appointment;

  AppointTabViewCommand({
    required this.presenter,
    required this.appointment
  });

  @override
  void execute() {
    presenter?.handleViewReceiptPressed(appointment!);
  }
}