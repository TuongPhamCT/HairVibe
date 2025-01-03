import '../Models/user_model.dart';

abstract class AdminContactListPageContract {
  void onLoadDataSucceeded();
  void onSelectBarber();
  void onSearch(List<UserModel> customerResults, List<UserModel> barberResults);
}