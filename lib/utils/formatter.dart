import 'package:flutter/material.dart';

class Formatter {
  static String timeFormatter({
    TimeOfDay? time,
    DateTime? dateTime,
    bool showDate = false,
  }) {
    String rtn = "";

    if (time == null && dateTime != null) {
      time = TimeOfDay.fromDateTime(dateTime);
    }

    if (time == null) {
      return "null";
    }

    if (showDate && dateTime != null) {
      final now = DateTime.now();
      final yesterday = DateTime(now.year, now.month, now.day - 1);

      final dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);

      if (dateOnly == yesterday) {
        rtn += "Yesterday at ";
      } else {
        rtn += "${dateTime.day} ${monthName(dateTime.month)} at ";
      }
    }

    rtn += time.hourOfPeriod.toString();
    rtn += ":";
    rtn += time.minute.toString().padLeft(2, "0");
    rtn += " ";
    rtn += time.period == DayPeriod.am ? "AM" : "PM";

    return rtn;
  }

  static String monthName(int month, {bool short = false}) {
    switch (month) {
      case 1:
        return short ? "Jan" : "January";
      case 2:
        return short ? "Feb" : "February";
      case 3:
        return short ? "Mar" : "March";
      case 4:
        return short ? "Apr" : "April";
      case 5:
        return short ? "May" : "May";
      case 6:
        return short ? "Jun" : "June";
      case 7:
        return short ? "Jul" : "July";
      case 8:
        return short ? "Aug" : "August";
      case 9:
        return short ? "Sep" : "September";
      case 10:
        return short ? "Oct" : "October";
      case 11:
        return short ? "Nov" : "November";
      case 12:
        return short ? "Dec" : "December";
      default:
        return "Invalid Month";
    }
  }

  static String countdown(Duration duration) {
    String rtn = "";

    rtn += duration.inMinutes.toString();
    rtn += ":";
    rtn += (duration.inSeconds - (duration.inMinutes * 60)).toString().padLeft(
      2,
      "0",
    );

    return rtn;
  }

  static String dateFormatter(DateTime date) {
    String rtn = "";

    rtn += date.year.toString();
    rtn += "-";

    rtn += date.month.toString();
    rtn += "-";

    rtn += date.day.toString();

    return rtn;
  }

  static String durationFormatter(
    Duration duration, {
    bool showSeconds = false,
  }) {
    String rtn = "";

    if (duration.inDays != 0) {
      rtn += duration.inDays.toString();
      rtn += "d ";
      duration -= Duration(days: duration.inDays);
    }

    if (duration.inHours != 0) {
      rtn += duration.inHours.toString();
      rtn += "h ";
      duration -= Duration(hours: duration.inHours);
    }

    if (duration.inMinutes >= 0) {
      rtn += duration.inMinutes.toString();
      rtn += "m";
      duration -= Duration(hours: duration.inMinutes);
    }

    if (showSeconds) {
      rtn += " ";
      rtn += duration.inSeconds.toString();
      rtn += "s";
    }

    return rtn;
  }

  static final months = [
    'Jan',
    'Fev',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static String prettyDate(int timestamp, {bool showTime = false}) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);

    int hour = date.hour;
    if (hour > 12) {
      hour -= 12;
    }

    if (hour == 0) {
      hour = 12;
    }

    if (showTime) {
      return '${hour < 10 ? '0$hour' : hour} : ${date.minute < 10 ? '0${date.minute}' : date.minute} ${date.hour < 12 ? 'AM' : 'PM'}, ${date.day} ${months[date.month - 1]} ${date.year - 2000}';
    } else {
      return '${date.day} ${months[date.month - 1]} ${date.year - 2000}';
    }
  }

  static String formatNumberMagnitude(double value) {
    List<String> suffixes = ["", "K", "M", "B", "T", "QT"];
    int magnitude = 0;

    while (value >= 1000) {
      value = value / 1000;
      magnitude++;
    }

    String formattedValue =
        value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(1);
    return '$formattedValue${suffixes[magnitude]}';
  }
}
