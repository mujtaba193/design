import 'package:design/where%20to%20design/users_model/timeline_model.dart';
import 'package:flutter/material.dart';
import 'package:mobkit_calendar/mobkit_calendar.dart';

class TableEvents extends StatefulWidget {
  List<TimeLineModel> timeLine;
  TableEvents({super.key, required this.timeLine});

  @override
  State<TableEvents> createState() => _TableEventsState();
}

class _TableEventsState extends State<TableEvents> {
  List<MobkitCalendarAppointmentModel> eventList = [];
  @override
  void initState() {
    // TODO: implement initState
    eventList = [
      ...widget.timeLine.map(
        (e) => MobkitCalendarAppointmentModel(
          title: e.price.toString(),
          appointmentStartDate: e.startTime,
          appointmentEndDate: e.endTime,
          isAllDay: false,
          color: Colors.green,
          detail: "The event will take place between 4 and 6 p.m.",
          recurrenceModel: null,
        ),
      )
    ];
    super.initState();
  }

  MobkitCalendarConfigModel getConfig(
      MobkitCalendarViewType mobkitCalendarViewType) {
    return MobkitCalendarConfigModel(
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
          color: Colors.blue,
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
          viewType: MobkitCalendarViewType.daily,
          appointmentList: eventList,
        ),
      ),
    );
  }
}
