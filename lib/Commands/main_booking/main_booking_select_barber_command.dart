import 'package:hairvibe/Commands/command_interface.dart';
import 'package:hairvibe/Models/user_model.dart';
import 'package:hairvibe/Presenter/main_booking_presenter.dart';

class MainBookingSelectBarberCommand implements CommandInterface {
  MainBookingPresenter? presenter;
  UserModel barber;
  int index;

  MainBookingSelectBarberCommand({
    required this.presenter,
    required this.barber,
    required this.index,
  });

  @override
  void execute() {
    presenter?.handleSelectBarber(barber, index);
  }

}