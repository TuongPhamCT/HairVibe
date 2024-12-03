import 'package:hairvibe/Models/user_model.dart';

abstract class EditAccountContract {
  void onEditSucceeded();
  void onEditFailed();
  void onLoadDataSucceed(UserModel model);
  void onWaitingProgressBar();
  void onPopContext();
  void onValidatingFailed(Map<String, String?> errors);
}