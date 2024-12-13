abstract class Utility {

  static String formatDurationFromSeconds (int? seconds) {
    if (seconds == null){
      return "-:-";
    }

    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;

    final String minutesStr = minutes.toString().padLeft(2, '0');
    final String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr";
  }

  static String formatCurrency(int? amount) {
    if (amount == null){
      return "00,000";
    }

    return amount!.toStringAsFixed(2).replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',');
  }
}