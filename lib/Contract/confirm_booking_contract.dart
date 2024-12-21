abstract class ConfirmBookingContract {
  void onAddVoucher();
  void onRemoveVoucher();
  void onChangeDependencies(bool result);
  void onConfirmBooking();
  void onWaitingProgressBar();
  void onPopContext();
}