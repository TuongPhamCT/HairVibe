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

    return amount.toStringAsFixed(2).replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',');
  }

  static String formatStringFromDateTime(DateTime? dateTime) {
    if (dateTime == null) {
      return "MM dd, YYYY - hh:mm AM";
    }

    const List<String> months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    String month = months[dateTime.month - 1];

    int hour = dateTime.hour;
    String period = hour >= 12 ? "PM" : "AM";
    hour = hour % 12 == 0 ? 12 : hour % 12;
    String minute = dateTime.minute.toString().padLeft(2, '0');

    return "$month ${dateTime.day}, ${dateTime.year} - $hour:$minute $period";
  }

  static String formatDateFromDateTime(DateTime? dateTime) {
    if (dateTime == null) {
      return "MM dd, YYYY";
    }

    const List<String> months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    String month = months[dateTime.month - 1];

    return "$month ${dateTime.day}, ${dateTime.year}";
  }

  static String formatTimeFromDateTime(DateTime? dateTime) {
    if (dateTime == null) {
      return "hh:mm AM";
    }

    int hour = dateTime.hour;
    String period = hour >= 12 ? "PM" : "AM";
    hour = hour % 12 == 0 ? 12 : hour % 12;
    String minute = dateTime.minute.toString().padLeft(2, '0');

    return "$hour:$minute $period";
  }
}