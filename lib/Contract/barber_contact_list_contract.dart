import '../Models/user_model.dart';

abstract class BarberContactListPageContract {
  void onLoadDataSucceeded();
  //void onSelectBarber();
  void onSearch(List<UserModel> customerResults);
} 