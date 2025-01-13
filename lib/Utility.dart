import 'package:flutter/material.dart';
import 'package:hairvibe/Models/notice_model.dart';
import 'package:hairvibe/Models/notice_repo.dart';

abstract class Utility {

  static String formatDurationFromSeconds (int? seconds) {
    if (seconds == null){
      return "--";
    }

    final int hours = seconds ~/ 3600;
    final int minutes = (seconds % 3600) ~/60;

    // final String hoursStr = minutes.toString().padLeft(2, '0');
    // final String minutesStr = minutes.toString().padLeft(2, '0');

    if (hours == 0) {
      return "$minutes minutes";
    }
    return "{$hours}h ${minutes}m";
  }

  static String formatCurrency(int? amount) {
    if (amount == null){
      return "00,000";
    }

    String value = amount.toStringAsFixed(2).replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',');
    return "$value\$";
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

  static bool isSameDate(DateTime? date1, DateTime? date2) {
    if (date1 == null || date2 == null) {
      return false;
    }
    return
        date1.year == date2.year
        && date1.month == date2.month
        && date1.day == date2.day;
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

  static List<DateTime> getCurrentWeekDates() {
    // Lấy ngày hiện tại
    DateTime now = DateTime.now();

    // Xác định ngày đầu tuần (Monday)
    int currentWeekday = now.weekday; // Thứ hiện tại (1 = Monday, 7 = Sunday)
    DateTime startOfWeek = now.subtract(Duration(days: currentWeekday - 1));

    // Tạo danh sách các ngày trong tuần
    List<DateTime> weekDates = List.generate(7, (index) {
      DateTime date = startOfWeek.add(Duration(days: index));
      // Đảm bảo chỉ giữ year, month, day, và reset giờ, phút, giây
      return DateTime(date.year, date.month, date.day);
    });

    return weekDates;
  }

  static roundDouble(double value, int decimals) {
    return double.parse(value.toStringAsFixed(decimals));
  }

  static String getDayOfWeekText(int index) {
    final daysOfWeek = ["0", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    return daysOfWeek[index];
  }

  static Future<void> waitDuration(int milliseconds) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }
}