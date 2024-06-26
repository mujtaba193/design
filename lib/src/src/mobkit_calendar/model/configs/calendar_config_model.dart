// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design/src/src/mobkit_calendar/model/configs/agenda_view_config_model.dart';
import 'package:design/src/src/mobkit_calendar/model/configs/calendar_cell_config_model.dart';
import 'package:design/src/src/mobkit_calendar/model/configs/calendar_popup_config_model.dart';
import 'package:design/src/src/mobkit_calendar/model/configs/calendar_top_bar_config_model.dart';
import 'package:design/src/src/mobkit_calendar/model/configs/daily_items_config_model.dart';
import 'package:flutter/material.dart';

//import '../../../../mobkit_calendar.dart';

class MobkitCalendarConfigModel {
  /// The title you want to appear at the top of the calendar.
  String? title;

  /// It determines in which locale the calendar will work.
  String? locale;

  /// Whether the calendar will show all days
  bool showAllDays;

  /// Turns off all dates of the calendar
  bool disableOffDays;

  /// Whether to show the bar showing the days of the week above the calendar
  bool disableWeekendsDays;

  /// It determines which days of the week to disable.
  List<int>? disableWeekDays;

  /// The calendar closes before the specified date.
  DateTime? disableBefore;

  /// The calendar closes after the specified date.
  DateTime? disableAfter;

  /// Specifies which types the calendar will turn off.
  List<DateTime>? disabledDates;

  /// Space inside the cells of the calendar
  EdgeInsetsGeometry itemSpace;

  /// Animation Duration
  Duration animationDuration;

  /// The main theme color of your calendar
  Color primaryColor;

  /// Determines the grid border color on the calendar
  Color gridBorderColor;

  /// If non-null, the corners of this box are rounded.
  BorderRadiusGeometry borderRadius;

  /// Determines the border color of the WeekDaysBar.
  Color weekDaysBarBorderColor;

  /// Determines whether a popup will open when the event is clicked.
  bool popupEnable;

  /// It allows you to customize the Popup that will open when the event is clicked.
  CalendarPopupConfigModel? calendarPopupConfigModel;

  double? viewportFraction;
  bool? showEventOffDay;
  double? monthBetweenPadding;
  double? agendaDayBetweenPadding;
  bool? showEventLineMaxCountText;
  bool? showEventPointMaxCountText;
  double? weeklyTopWidgetSize;
  double? dailyTopWidgetSize;

  late CalendarCellConfigModel cellConfig;
  late CalendarTopBarConfigModel topBarConfig;
  late DailyItemsConfigModel dailyItemsConfigModel;
  AgendaViewConfigModel? agendaViewConfigModel;
  MobkitCalendarConfigModel({
    this.title,
    this.locale,
    this.showAllDays = true,
    this.disableOffDays = true,
    this.disableWeekendsDays = true,
    this.disableBefore,
    this.disableWeekDays,
    this.disableAfter,
    this.disabledDates,
    this.itemSpace = const EdgeInsets.all(2.0),
    this.animationDuration = const Duration(milliseconds: 300),
    this.primaryColor = const Color.fromRGBO(253, 165, 46, 1),
    this.gridBorderColor = Colors.transparent,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.weekDaysBarBorderColor = const Color.fromRGBO(253, 165, 46, 1),
    this.popupEnable = false,
    this.calendarPopupConfigModel,
    this.viewportFraction = 1.0,
    this.showEventOffDay = false,
    this.monthBetweenPadding = 0,
    this.agendaDayBetweenPadding = 0,
    this.showEventLineMaxCountText = true,
    this.showEventPointMaxCountText = true,
    this.weeklyTopWidgetSize = 110,
    this.dailyTopWidgetSize = 110,
    CalendarCellConfigModel? cellConfig,
    CalendarTopBarConfigModel? topBarConfig,
    DailyItemsConfigModel? dailyItemsConfigModel,
    AgendaViewConfigModel? agendaViewConfigModel,
  }) {
    this.cellConfig = cellConfig ?? CalendarCellConfigModel();
    this.topBarConfig = topBarConfig ?? CalendarTopBarConfigModel();
    this.dailyItemsConfigModel =
        dailyItemsConfigModel ?? DailyItemsConfigModel();
  }
}
