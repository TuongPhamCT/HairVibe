abstract class SignUpTabContract {
  void onWaitingProgressBar() {}
  void onPopContext() {}
  void onEmailAlreadyInUse() {}
  void onSignUpSucceeded() {}
  void onSignUpFailed() {}
  void onValidatingFailed(Map<String, String?> errors) {}
}