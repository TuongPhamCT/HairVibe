import 'package:hairvibe/ChainOfRes/validation/validation_target.dart';

abstract class AddBarberScreenContract {
  void onBack();
  void onSave();
  void onValidatingFailed(ValidationTarget errors);
  void onWaitingProgressBar();
  void onPopContext();
  void onEmailAlreadyInUse();
  void onSignUpFailed();
}