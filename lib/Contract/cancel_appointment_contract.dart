abstract class CancelAppointmentPageContract {
  void onWaitingProgressBar();
  void onPopContext();
  void onConfirmSucceed();
  void onConfirmFailed(String error);
}