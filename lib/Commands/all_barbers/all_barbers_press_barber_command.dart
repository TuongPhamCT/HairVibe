import 'package:hairvibe/Presenter/barber_screen_presenter.dart';

import '../../Models/user_model.dart';
import '../command_interface.dart';

class AllBarbersPressBarberCommand implements CommandInterface {
  BarberScreenPresenter? presenter;
  UserModel barberModel;

  AllBarbersPressBarberCommand({
    required this.presenter,
    required this.barberModel
  });

  @override
  void execute() {
    presenter?.handleDetailBarberPressed(barberModel);
  }
}