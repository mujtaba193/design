import 'package:design/src/src/calendar.dart';
import 'package:design/src/src/mobkit_calendar/controller/mobkit_calendar_controller.dart';
import 'package:design/src/src/mobkit_calendar/enum/mobkit_calendar_view_type_enum.dart';
import 'package:design/src/src/mobkit_calendar/model/configs/calendar_cell_config_model.dart';
import 'package:design/src/src/mobkit_calendar/model/configs/calendar_config_model.dart';
import 'package:design/src/src/mobkit_calendar/model/configs/calendar_top_bar_config_model.dart';
import 'package:design/src/src/mobkit_calendar/model/configs/daily_items_config_model.dart';
import 'package:design/src/src/mobkit_calendar/model/mobkit_calendar_appointment_model.dart';
import 'package:design/src/src/mobkit_calendar/model/styles/calendar_cell_style.dart';
import 'package:design/whereToDesign/models/timeline_model.dart';
import 'package:flutter/material.dart';

class TableEvents extends StatefulWidget {
  List<TimeLineModel> timeLine;
  DateTime selectedDate;
  TableEvents({super.key, required this.timeLine, required this.selectedDate});

  @override
  State<TableEvents> createState() => _TableEventsState();
}

class _TableEventsState extends State<TableEvents> {
  List<MobkitCalendarAppointmentModel> eventList = [];
  late int minimam;
  late int mediam;
  late int maximam;
  late List<int> allPrice;

  @override
  void initState() {
    // TODO: implement initState
    sortingPrice();
    eventList = [
      ...widget.timeLine.map(
        (e) => MobkitCalendarAppointmentModel(
          title: e.price.toString(),
          appointmentStartDate: e.startTime,
          appointmentEndDate: e.endTime,
          isAllDay: false,
          color: minimam <= e.price && mediam > e.price
              ? Colors.green.withOpacity(0.5)
              : mediam <= e.price && maximam > e.price
                  ? Colors.yellow.withOpacity(0.5)
                  : maximam == e.price
                      ? Colors.red.withOpacity(0.5)
                      : null,
          detail: "The event will take place between 4 and 6 p.m.",
          recurrenceModel: null,
        ),
      )
    ];
    super.initState();
  }

  sortingPrice() {
    allPrice = widget.timeLine.map((e) => e.price).toList();
    allPrice.sort();
    minimam = allPrice.first;
    maximam = allPrice.last;
    // mediam = allPrice[(allPrice.length / 2).floor()];
    mediam = ((minimam + maximam) / 2).floor();
  }

  MobkitCalendarConfigModel getConfig(
      MobkitCalendarViewType mobkitCalendarViewType) {
    return MobkitCalendarConfigModel(
      borderRadius: BorderRadius.circular(20),
      dailyItemsConfigModel:
          DailyItemsConfigModel(hourTextStyle: TextStyle(color: Colors.white)),

      cellConfig: CalendarCellConfigModel(
        disabledStyle: CalendarCellStyle(
          textStyle:
              TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.5)),
          // color: Colors.transparent,
        ),
        enabledStyle: CalendarCellStyle(
          //  textStyle: const TextStyle(fontSize: 14, color: Colors.black),
          border: Border.all(color: Colors.green, width: 1),
        ),
        selectedStyle: CalendarCellStyle(
          color: Colors.blue.withOpacity(0.5),
          textStyle: const TextStyle(fontSize: 14, color: Colors.white),
          border: Border.all(color: Colors.white, width: 1),
        ),
        currentStyle: CalendarCellStyle(
          textStyle: const TextStyle(color: Colors.lightBlue),
        ),
      ),
      // calendarPopupConfigModel: CalendarPopupConfigModel(
      //   popUpBoxDecoration: const BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.all(Radius.circular(25))),
      //   popUpOpacity: true,
      //   animateDuration: 500,
      //   verticalPadding: 30,
      //   popupSpace: 10,
      //   popupHeight: MediaQuery.of(context).size.height * 0.6,
      //   popupWidth: MediaQuery.of(context).size.width,
      //   viewportFraction: 0.9,
      // ),
      topBarConfig: CalendarTopBarConfigModel(
        isVisibleHeaderWidget:
            mobkitCalendarViewType == MobkitCalendarViewType.monthly ||
                mobkitCalendarViewType == MobkitCalendarViewType.agenda,
        isVisibleTitleWidget: true,
        isVisibleMonthBar: true,
        isVisibleYearBar: true,
        isVisibleWeekDaysBar: true,
        weekDaysStyle: const TextStyle(
          fontSize: 14,
        ),
      ),
      weekDaysBarBorderColor: Colors.purple,
      locale: "en",
      disableOffDays: true,
      disableWeekendsDays: false,
      monthBetweenPadding: 20,
      primaryColor: Colors.lightBlue,
      popupEnable: mobkitCalendarViewType == MobkitCalendarViewType.monthly
          ? true
          : false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: MobkitCalendarWidget(
        minDate: DateTime(1800),
        key: UniqueKey(),
        config: getConfig(MobkitCalendarViewType.daily),
        dateRangeChanged: (datetime) => null,
        headerWidget:
            (List<MobkitCalendarAppointmentModel> models, DateTime datetime) =>
                Text('ABC'),
        // titleWidget:
        //     (List<MobkitCalendarAppointmentModel> models, DateTime datetime) =>
        //         Text('ABC2'),
        onSelectionChange:
            (List<MobkitCalendarAppointmentModel> models, DateTime date) =>
                null,
        eventTap: (model) => null,
        onPopupWidget:
            (List<MobkitCalendarAppointmentModel> models, DateTime datetime) =>
                Text('ABC3'),
        onDateChanged: (DateTime datetime) => null,
        mobkitCalendarController: MobkitCalendarController(
          calendarDateTime: widget.selectedDate,
          selectedDateTime: widget.selectedDate,
          viewType: MobkitCalendarViewType.daily,
          appointmentList: eventList,
        ),
      ),
    );
  }
}
