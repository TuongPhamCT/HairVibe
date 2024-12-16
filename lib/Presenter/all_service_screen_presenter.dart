import 'package:hairvibe/Models/service_model.dart';
import 'package:hairvibe/Models/service_repo.dart';

import '../Contract/all_service_screen_contract.dart';

class AllServiceScreenPresenter {
  final AllServiceScreenContract _view;
  AllServiceScreenPresenter(this._view);

  final ServiceRepository _serviceRepo = ServiceRepository();

  List<ServiceModel> serviceList = [];

  Future<void> getData() async {
    serviceList = await _serviceRepo.getAllServices();

    _view.onLoadDataSucceed();
  }

  void handleServicePressed(ServiceModel model) {
    _view.onServicePressed();
  }
}