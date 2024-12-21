import 'package:flutter/material.dart';

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

  static String getRatingDate(DateTime? dateTime) {
    return "";
  }

  static DateTime getTodayDate() {
    DateTime today = DateTime.now();
    DateTime convert = DateTime(today.year, today.month, today.day, 0, 0, 0, 0 ,0);
    return convert;
  }

  static String formatRatingValue(double? value) {
    return value?.toStringAsFixed(1) ?? "4.5";
  }

  static TimeOfDay convertIntToTimeOfDay(int value) {
    int hour = value ~/ 60;
    int minutes = value % 60;
    return TimeOfDay(hour: hour, minute: minutes);
  }

  static int convertTimeOfDayToInt(TimeOfDay time) {
    return time.hour * 60 + time.minute;
  }

  static TimeOfDay getTimeOfDayFromDateTime (DateTime date) {
    return TimeOfDay(hour: date.hour, minute: date.minute);
  }

  static DateTime getDateTimeFromDateAndTimeOfDay(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute, 0, 0, 0);
  }

  static bool isScheduleConflicted(
    TimeOfDay startTime1, Duration duration1,
    TimeOfDay startTime2, Duration duration2
  ){
    int startT1 = Utility.convertTimeOfDayToInt(startTime1);
    int endT1 = Utility.convertTimeOfDayToInt(startTime1) + duration1.inMinutes;
    int startT2 = Utility.convertTimeOfDayToInt(startTime2);
    int endT2 = Utility.convertTimeOfDayToInt(startTime2) + duration2.inMinutes;

    if (endT1 <= startT2 || startT1 >= endT2) {
      return false;
    }
    return true;
  }
}