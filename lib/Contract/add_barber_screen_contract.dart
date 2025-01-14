abstract class AddBarberScreenContract {
  void onBack();
  void onSave();
  void onValidatingFailed(Map<String, String?> errors);
  void onWaitingProgressBar();
  void onPopContext();
  void onEmailAlreadyInUse();
  void onSignUpFailed();
}