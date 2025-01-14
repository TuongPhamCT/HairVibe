import 'package:hairvibe/Presenter/home_screen_presenter.dart';

import '../../Models/service_model.dart';
import '../command_interface.dart';

class HomeScreenPressServiceCommand implements CommandInterface {
  HomeScreenPresenter? presenter;
  ServiceModel serviceModel;

  HomeScreenPressServiceCommand({
    required this.presenter,
    required this.serviceModel
  });

  @override
  void execute() {
    presenter?.handleServicePressed(serviceModel);
  }
}