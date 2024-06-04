import 'package:flutter/widgets.dart';

class DateUtil {
  static const int DAYS_IN_WEEK = 7;

  static const List<String> MONTH_LABEL = [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static const List<String> SHORT_MONTH_LABEL = [
    '',
    'Jan',
    'Feb',
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

  static const List<String> WEEK_LABEL = [
    '',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  /// Get start day of month.
  static DateTime startDayOfMonth(final DateTime referenceDate) =>
      DateTime(referenceDate.year, referenceDate.month, 1);

  /// Get last day of month.
  static DateTime endDayOfMonth(final DateTime referenceDate) =>
      DateTime(referenceDate.year, referenceDate.month + 1, 0);

  /// Get exactly one year before of [referenceDate].
  static DateTime oneYearBefore(final DateTime referenceDate) =>
      DateTime(referenceDate.year - 1, referenceDate.month, referenceDate.day);

  /// Separate [referenceDate]'s month to List of every weeks.

  static List<Map<DateTime, DateTime>> separatedMonth(
      final DateTime referenceDate) {
    DateTime _startDate = startDayOfMonth(referenceDate);
    // DateTime _startDate = firstDayWeek(referenceDate);

    DateTime _endDate = DateTime(_startDate.year, _startDate.month,
        _startDate.day + DAYS_IN_WEEK - _startDate.weekday % DAYS_IN_WEEK - 1);
    // DateTime _endDate = DateTime(_startDate.year, _startDate.month,
    //     DateTime.daysPerWeek - _startDate.weekday);
    //DateTime _endDate = lastDayWeek(referenceDate);
    DateTime _finalDate = endDayOfMonth(referenceDate);
    List<Map<DateTime, DateTime>> _savedMonth = [];

    while (_startDate.isBefore(_finalDate) || _startDate == _finalDate) {
      _savedMonth.add({_startDate: _endDate});
      _startDate = changeDay(_endDate, 1);
      _endDate = changeDay(
          _endDate,
          endDayOfMonth(_endDate).day - _startDate.day >= DAYS_IN_WEEK
              ? DAYS_IN_WEEK
              : endDayOfMonth(_endDate).day - _startDate.day + 1);
    }
    return _savedMonth;
  }

  /// Change day of [referenceDate].
  static DateTime changeDay(final DateTime referenceDate, final int dayCount) =>
      DateTime(referenceDate.year, referenceDate.month,
          referenceDate.day + dayCount);

  /// Change month of [referenceDate].
  static DateTime changeMonth(final DateTime referenceDate, int monthCount) =>
      DateTime(referenceDate.year, referenceDate.month + monthCount,
          referenceDate.day);
}
// ???????????????????????????????????????????????????????????????????

// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

/// Signature for a function that creates a widget for a given `day`.
typedef DayBuilder = Widget? Function(BuildContext context, DateTime day);

/// Signature for a function that creates a widget for a given `day`.
/// Additionally, contains the currently focused day.
typedef FocusedDayBuilder = Widget? Function(
    BuildContext context, DateTime day, DateTime focusedDay);

/// Signature for a function returning text that can be localized and formatted with `DateFormat`.
typedef TextFormatter = String Function(DateTime date, dynamic locale);

/// Gestures available for the calendar.
enum AvailableGestures { none, verticalSwipe, horizontalSwipe, all }

/// Formats that the calendar can display.
enum CalendarFormat { month, twoWeeks, week }

/// Days of the week that the calendar can start with.
enum StartingDayOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

/// Returns a numerical value associated with given `weekday`.
///
/// Returns 1 for `StartingDayOfWeek.monday`, all the way to 7 for `StartingDayOfWeek.sunday`.
int getWeekdayNumber(StartingDayOfWeek weekday) {
  return StartingDayOfWeek.values.indexOf(weekday) + 1;
}

/// Returns `date` in UTC format, without its time part.
DateTime normalizeDate(DateTime date) {
  return DateTime.utc(date.year, date.month, date.day);
}

/// Checks if two DateTime objects are the same day.
/// Returns `false` if either of them is null.
bool isSameDay(DateTime? a, DateTime? b) {
  if (a == null || b == null) {
    return false;
  }

  return a.year == b.year && a.month == b.month && a.day == b.day;
}


///???????????????????????????????????????????????????????????????????
  //#region unused methods.

  // static int weekCount(final DateTime referenceDate) {
  //   return ((startDayOfMonth(referenceDate).weekday % DAYS_IN_WEEK +
  //               endDayOfMonth(referenceDate).day) /
  //           DAYS_IN_WEEK)
  //       .ceil();
  // }

  // static int weekPos(final DateTime referenceDate) =>
  //     (referenceDate.day +
  //         startDayOfMonth(referenceDate).weekday % DAYS_IN_WEEK) ~/
  //     DAYS_IN_WEEK;

  // static DateTime startDayOfWeek(final DateTime referenceDate) =>
  //     weekPos(referenceDate) == 0
  //         ? startDayOfMonth(referenceDate)
  //         : DateTime(referenceDate.year, referenceDate.month,
  //             referenceDate.day - referenceDate.weekday % DAYS_IN_WEEK);

  // static DateTime endDayOfWeek(final DateTime referenceDate) {
  //   return weekPos(referenceDate) != (weekCount(referenceDate) - 1)
  //       ? DateTime(referenceDate.year, referenceDate.month,
  //           referenceDate.day - referenceDate.weekday % DAYS_IN_WEEK + 6)
  //       : endDayOfMonth(referenceDate);
  // }

  // static DateTime changeWeek(final DateTime referenceDate, int weekCount) =>
  //     DateTime(referenceDate.year, referenceDate.month,
  //         1 + DAYS_IN_WEEK * weekCount);

  // static bool compareDate(final DateTime first, final DateTime second) =>
  //     first.year == second.year &&
  //     first.month == second.month &&
  //     first.day == second.day;

  // static bool isStartDayOfMonth(final DateTime referenceDate) =>
  //     compareDate(referenceDate, startDayOfMonth(referenceDate));

  //#endregion
//}
