import 'package:hairvibe/Presenter/barber_screen_presenter.dart';

import '../../Models/user_model.dart';
import '../command_interface.dart';

class AllBarbersBookBarberCommand implements CommandInterface {
  BarberScreenPresenter? presenter;
  UserModel barberModel;

  AllBarbersBookBarberCommand({
    required this.presenter,
    required this.barberModel
  });

  @override
  void execute() {
    presenter?.handleBookBarberPressed(barberModel);
  }
}