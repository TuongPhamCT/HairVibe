import 'package:hairvibe/Const/app_config.dart';
import 'package:hairvibe/Contract/barber_contact_list_contract.dart';
import 'package:hairvibe/Models/user_model.dart';
import 'package:hairvibe/Models/user_repo.dart';

class BarberContactListPagePresenter {
  final BarberContactListPageContract _view;
  BarberContactListPagePresenter(this._view);

  final UserRepository _userRepo = UserRepository(AppConfig.dbType);

  List<UserModel> customers = [];

  Future<void> getData() async {
    customers = await _userRepo.getAllCustomers();

    _view.onLoadDataSucceeded();
  }

  void handleSearch(String input) {
    if (input.isEmpty) {
      _view.onSearch(customers);
      return;
    }

    List<UserModel> customerResults = [];

    // Search User Tab
    for (UserModel model in customers) {
      if (model.name!.contains(input)) {
        customerResults.add(model);
      }
    }

    _view.onSearch(customerResults);
  }

  void handleBarberPressed(UserModel barber) {}
}
