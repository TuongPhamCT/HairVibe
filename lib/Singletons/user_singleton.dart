import '../Models/user_model.dart';
import 'notification_singleton.dart';

class UserSingleton {
  static UserSingleton? _instance;

  static UserSingleton getInstance() {
    _instance ??= UserSingleton();
    return _instance!;
  }

  UserModel? currentUser;

  bool currentUserIsCustomer() {
    return currentUser != null
        && currentUser!.userType == UserType.CUSTOMER;
  }

  bool currentUserIsBarber() {
    return currentUser != null
        && currentUser!.userType == UserType.BARBER;
  }

  bool currentUserIsAdmin() {
    return currentUser != null
        && currentUser!.userType == UserType.ADMIN;
  }

  void setCurrentUser(UserModel model) {
    currentUser = model;
  }

  Future<void> handleActionsAfterLogin() async {
    NotificationSingleton singleton = NotificationSingleton.getInstance();
    singleton.initialize();
  }

  Future<void> handleActionsAfterLogOut() async {
    NotificationSingleton singleton = NotificationSingleton.getInstance();
    singleton.dispose();
  }
}