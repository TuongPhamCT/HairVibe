abstract class MainBookingContract {
  void onLoadDataSucceed();
  void onSelectService();
  void onSelectDate();
  void onSelectTime();
  void onSelectBarber(int index);
  void onNext();
  void onValidatingFailed(String message);
  void onWaitingProgressBar();
  void onPopContext();
}