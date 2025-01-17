import 'package:hairvibe/Const/app_config.dart';
import 'package:hairvibe/Contract/add_service_page_contract.dart';
import 'package:hairvibe/Models/service_repo.dart';

import '../Models/service_model.dart';

class AddServicePagePresenter {
  final AddServicePageContract _view;
  AddServicePagePresenter(this._view);

  final ServiceRepository _serviceRepo = ServiceRepository(AppConfig.dbType);

  Future<void> handleCreateService({
    required String name,
    required String price,
    required String duration,
    required String description
  }) async {
    if (name.isEmpty
      || price.isEmpty
      || duration.isEmpty
      || description.isEmpty
    ) {
      _view.onCreateFailed("Please complete all required fields");
      return;
    }

    int priceNumber;

    try {
      priceNumber = int.parse(price);
    } catch(e) {
      _view.onCreateFailed("Price number is incorrect");
      return;
    }

    _view.onWaitingProgressBar();
    ServiceModel service = ServiceModel(
      name: name,
      price: priceNumber,
      duration: int.parse(duration),
      info: description
    );

    if (await _serviceRepo.addService(service) != "") {
      _view.onPopContext();
      _view.onCreateSucceeded();
    } else {
      _view.onPopContext();
      _view.onCreateFailed("Something was wrong. Please try again.");
    }
  }
}