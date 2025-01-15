abstract class RatingBarberContract {
  void onWaitingProgressBar();
  void onPopContext();
  void onRatingSucceeded();
  void onRatingFailed(String message);
}