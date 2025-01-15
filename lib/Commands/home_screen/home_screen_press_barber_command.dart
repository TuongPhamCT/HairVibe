import '../../Models/user_model.dart';
import '../../Presenter/home_screen_presenter.dart';
import '../command_interface.dart';

class HomeScreenPressBarberCommand implements CommandInterface {
  HomeScreenPresenter? presenter;
  UserModel? barber;

  HomeScreenPressBarberCommand({
    required this.presenter,
    required this.barber
  });

  @override
  void execute() {
    presenter?.handleBarberPressed(barber!);
  }
}