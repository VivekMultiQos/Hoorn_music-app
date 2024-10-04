import 'package:intl/intl.dart';

const String fullDateFormat = 'yyyy-MM-ddTHH:mm:ss.SSSZ';

class DateTimeFormatter {
  static const String _dateFormat = 'yyyy-MM-dd';

  static String getTimeAgo({required int timestamp}) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var localTimeZoneDate = date.toLocal();
    return localTimeZoneDate.timeAgo;
  }

  /// This will convert DateTime into String
  static String stringFromDate(
      {required DateTime dateTime, String format = _dateFormat, String? locale}) {
    String dateString = DateFormat(format, locale).format(dateTime);
    return dateString;
  }

  /// This will convert string into DateTime
  static DateTime dateFromString(
      {required String date, String format = _dateFormat, bool utc = false}) {
    DateTime dateT = DateFormat(format).parse(date, utc);
    return dateT;
  }

  /// This will convert DateTime into DateTime in given format.
  static DateTime dateFromDate(
      {required DateTime dateTime, String format = _dateFormat, bool utc = false}) {
    var strDate =  DateTimeFormatter.stringFromDate(dateTime: dateTime, format: format);
    var dateT = DateTimeFormatter.dateFromString(date: strDate, format: format);
    return dateT;
  }

  /// This will convert timestamp into DateTime
  static DateTime dateFromTimestamp({required int timestamp}) {
    return DateTime.fromMicrosecondsSinceEpoch(timestamp);
  }

  /// This will convert string into DateTime
  static String stringFromTimestamp(
      {required int timestamp, String format = _dateFormat}) {
    var date = DateTimeFormatter.dateFromTimestamp(timestamp: timestamp);
    return DateTimeFormatter.stringFromDate(dateTime: date);
  }

  /// This will convert DateTime into timestamp.
  static int timestampFromDate({required DateTime dateTime}) {
    return dateTime.millisecondsSinceEpoch;
  }

  /// This will convert String into timestamp.
  static int timestampFromString({
    required String dateTime,
    String format = _dateFormat,
    bool utc = false,
  }) {
    var date = DateTimeFormatter.dateFromString(
        date: dateTime, format: format, utc: utc);
    return date.millisecondsSinceEpoch;
  }
}

extension TimeAgo on DateTime {
  String get timeAgo {
    // final now = DateTime.now();
    // final today = DateTime(now.year, now.month, now.day);
    //
    // var diff = today.difference(this);
    // if (diff.inDays > 365) {
    //   return '${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1
    //       ? kYear
    //       : kYears} $kAgo';
    // }
    // if (diff.inDays > 30) {
    //   return '${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1
    //       ? kMonth
    //       : kMonths} $kAgo';
    // }
    // if (diff.inDays > 7) {
    //   return '${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1
    //       ? kWeek
    //       : kWeeks} $kAgo';
    // }
    // if (diff.inDays > 0) {
    //   return '${diff.inDays} ${diff.inDays == 1 ? kDay : kDays} $kAgo';
    // }
    //
    // final timeDiff = now.difference(this);
    // if (timeDiff.inHours > 0) {
    //   return '${timeDiff.inHours} ${timeDiff.inHours == 1
    //       ? kHour
    //       : kHours} $kAgo';
    // }
    // if (timeDiff.inMinutes > 0) {
    //   return '${timeDiff.inMinutes} ${timeDiff.inMinutes == 1
    //       ? kMinute
    //       : kMinutes} $kAgo';
    // }
    // return kJustNow;

    return '';
  }
}
