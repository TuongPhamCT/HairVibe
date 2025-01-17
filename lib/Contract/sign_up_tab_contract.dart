import 'package:hairvibe/ChainOfRes/validation/validation_target.dart';

abstract class SignUpTabContract {
  void onWaitingProgressBar() {}
  void onPopContext() {}
  void onEmailAlreadyInUse() {}
  void onSignUpSucceeded() {}
  void onSignUpFailed() {}
  void onValidatingFailed(ValidationTarget errorTexts) {}
}