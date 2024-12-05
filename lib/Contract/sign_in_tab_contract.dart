abstract class SignInTabContract {
  void onLoginSucceeded();
  void onLoginFailed();
  void onInvalidEmailOrPassword();
  void onWaitingProgressBar();
  void onPopContext();
}