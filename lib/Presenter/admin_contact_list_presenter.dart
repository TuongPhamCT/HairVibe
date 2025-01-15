import 'package:hairvibe/Contract/admin_contact_list_contract.dart';
import 'package:hairvibe/Models/user_model.dart';
import 'package:hairvibe/Models/user_repo.dart';
import 'package:hairvibe/Singletons/barber_singleton.dart';

class AdminContactListPagePresenter {
  final AdminContactListPageContract _view;
  AdminContactListPagePresenter(this._view);

  final UserRepository _userRepo = UserRepository();

  List<UserModel> customers = [];
  List<UserModel> barbers = [];

  Future<void> getData() async {
    customers = await _userRepo.getAllCustomers();
    barbers = await _userRepo.getAllBarbers();

    _view.onLoadDataSucceeded();
  }

  void handleSearch(String input) {
    if (input.isEmpty) {
      _view.onSearch(customers, barbers);
      return;
    }

    List<UserModel> customerResults = [];
    List<UserModel> barberResults = [];
    // Search User Tab
    for (UserModel model in customers) {
      if (model.name!.contains(input)) {
        customerResults.add(model);
      }
    }
    // Search Barber Tab
    for (UserModel model in barbers) {
      if (model.name!.contains(input)) {
        barberResults.add(model);
      }
    }

    _view.onSearch(customerResults, barberResults);
  }

  void handleBarberPressed(UserModel barber) {
    BarberSingleton barberSingleton = BarberSingleton.getInstance();
    barberSingleton.setBarber(barber);
    _view.onSelectBarber();
  }
}