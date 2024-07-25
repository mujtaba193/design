// import 'package:flutter/material.dart';
// import 'package:mobkit_calendar/mobkit_calendar.dart';

// class MobCalendarPage extends StatefulWidget {
//   const MobCalendarPage({super.key});

//   @override
//   State<MobCalendarPage> createState() => _MobCalendarPageState();
// }

// class _MobCalendarPageState extends State<MobCalendarPage> {
//   late TabController _tabController;
//   MobkitCalendarConfigModel getConfig(
//       MobkitCalendarViewType mobkitCalendarViewType) {
//     return MobkitCalendarConfigModel(
//       cellConfig: CalendarCellConfigModel(
//         //////////////////////////////// (cellConfig)///////////////////////////////
//         disabledStyle: CalendarCellStyle(
//           textStyle:
//               TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.5)),
//           color: Colors.transparent,
//         ),
//         enabledStyle: CalendarCellStyle(
//           textStyle: const TextStyle(fontSize: 14, color: Colors.black),
//           border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
//         ),
//         selectedStyle: CalendarCellStyle(
//           color: Colors.orange,
//           textStyle: const TextStyle(fontSize: 14, color: Colors.white),
//           border: Border.all(color: Colors.black, width: 1),
//         ),
//         currentStyle: CalendarCellStyle(
//           textStyle: const TextStyle(color: Colors.lightBlue),
//         ),
//       ),
//       //////////////////////////////// (calendarPopupConfigModel)///////////////////////////////
//       calendarPopupConfigModel: CalendarPopupConfigModel(
//         popUpBoxDecoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(
//             Radius.circular(25),
//           ),
//         ),
//         popUpOpacity: true,
//         animateDuration: 500,
//         verticalPadding: 30,
//         popupSpace: 10,
//         popupHeight: MediaQuery.of(context).size.height * 0.6,
//         popupWidth: MediaQuery.of(context).size.width,
//         viewportFraction: 0.9,
//       ),
//       //////////////////////////////// (topBarConfig)///////////////////////////////
//       topBarConfig: CalendarTopBarConfigModel(
//         isVisibleHeaderWidget:
//             mobkitCalendarViewType == MobkitCalendarViewType.monthly,
//         isVisibleTitleWidget: true,
//         isVisibleMonthBar: false,
//         isVisibleYearBar: false,
//         isVisibleWeekDaysBar: true,
//         weekDaysStyle: const TextStyle(fontSize: 14, color: Colors.black),
//       ),
//       weekDaysBarBorderColor: Colors.transparent,
//       locale: "ru",
//       disableOffDays: true,
//       disableWeekendsDays: false,
//       monthBetweenPadding: 20,
//       primaryColor: Colors.lightBlue,
//       popupEnable:
//           mobkitCalendarViewType == MobkitCalendarViewType.daily ? true : false,
//     );
//   }

//   @override
//   void initState() {
//     // _tabController = TabController(length: 4, vsync: this);

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
