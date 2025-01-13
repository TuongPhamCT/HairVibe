abstract class AddServicePageContract {
  void onCreateSucceeded();
  void onCreateFailed(String message);
  void onBack();
  void onWaitingProgressBar();
  void onPopContext();
}