abstract class ForgotPassScreenContract {
  void onResetSucceeded();
  void onResetFailed();
  void onWaitingProgressBar();
  void onPopContext();
  void onEmailNotFound();
}