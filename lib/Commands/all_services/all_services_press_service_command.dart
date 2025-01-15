import 'package:hairvibe/Presenter/all_service_screen_presenter.dart';

import '../../Models/service_model.dart';
import '../command_interface.dart';

class AllServicesPressServiceCommand implements CommandInterface {
  AllServiceScreenPresenter? presenter;
  ServiceModel serviceModel;

  AllServicesPressServiceCommand({
    required this.presenter,
    required this.serviceModel
  });

  @override
  void execute() {
    presenter?.handleServicePressed(serviceModel);
  }
}