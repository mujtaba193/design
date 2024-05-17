import 'package:design/src/src/mobkit_calendar/controller/mobkit_calendar_controller.dart';
import 'package:design/src/src/mobkit_calendar/model/configs/calendar_config_model.dart';
import 'package:design/src/src/mobkit_calendar/model/mobkit_calendar_appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Creates the month information view available in various views of  [MobkitCalendarWidget].
class CalendarMonthSelectionBar extends StatelessWidget {
  final MobkitCalendarConfigModel? config;
  final MobkitCalendarController mobkitCalendarController;
  final Function(
          List<MobkitCalendarAppointmentModel> models, DateTime datetime)?
      onSelectionChange;

  const CalendarMonthSelectionBar(
      this.mobkitCalendarController, this.onSelectionChange, this.config,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: mobkitCalendarController,
      builder: (context, widget) {
        return Text(
          _parseDateStr(mobkitCalendarController.calendarDate),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }

  String _parseDateStr(DateTime date) {
    return DateFormat('MMMM', config?.locale).format(date);
  }
}
