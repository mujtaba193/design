import 'package:design/appconfig.dart';
import 'package:design/whereToDesign/models/boat_model.dart';
import 'package:design/whereToDesign/providers/city_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../providers/filter/search_filter_provider.dart';
import '../translation/search_filter_translation.dart';
import 'boat_provider_change_notifire.dart';

class SearchFilterChangeNotifier extends ConsumerStatefulWidget {
  List<BoatModel>? boatList;
  final BoatModel? boatinfo;
  bool? isSearch;
  SearchFilterChangeNotifier({
    Key? key,
    this.boatList,
    this.isSearch,
    this.boatinfo,
  }) : super(key: key);

  @override
  ConsumerState<SearchFilterChangeNotifier> createState() =>
      _SearchFilterChangeNotifierState();
}

class _SearchFilterChangeNotifierState
    extends ConsumerState<SearchFilterChangeNotifier> {
  TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  //double timeValue = 1.0;
  double timeValue2 = 1.0;
  // DateTime userTimeNow2 = DateTime.now().toLocal();
  DateTime timeNow1 = DateTime.now().toLocal();
  DateTime timeNow2 = DateTime.now().toLocal();
  DateTime date = DateTime.now().toLocal();
  /////////////////////////city///////////////////////////
  List<String> cityList = [];
  List<String> cityNameList = [];
  String? selectedCity;
  // String? selectedCityName;
  // List<Event>? cityEvents;
  // String? slectedevent;
  bool? captain;
  bool? rights;
  bool pets = false;
  bool disabilities = false;

  @override
  void initState() {
    final searchFilterState = ref.read(searchFilterProvider);
    final cityHolder = ref.read(cityProvider);
    // userTimeNow2 = userTimeNow1.add(Duration(hours: 1));
    // timeNow2 = timeNow1.add(Duration(hours: 1));
    if (cityHolder.selectedevent == null) {
      timeNow2 = timeNow1.add(Duration(hours: 1));
    } else {
      timeNow2 =
          timeNow1.add(Duration(hours: searchFilterState.timeValue2.toInt()));
    }
    super.initState();
  }

  datePicker() async {
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: timeNow1 ?? date,
        firstDate: DateTime.now(),
        lastDate: DateTime(3030));
    setState(() {
      if (dateTime != null) {
        timeNow1 = dateTime;
      }
    });
  }

  timePicker() async {
    final searchFilterState = ref.watch(searchFilterProvider);
    final cityHolder = ref.read(cityProvider);
    timeNow1 = DateTime(timeNow1.year, timeNow1.month, timeNow1.day);

    TimeOfDay? timeOfDay =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (timeOfDay != null) {
      setState(() {
        timeNow1 = timeNow1
            .add(Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute));
        if (cityHolder.selectedevent == null) {
          timeNow2 = timeNow1.add(Duration(hours: 1));
        } else {
          timeNow2 = timeNow1
              .add(Duration(hours: searchFilterState.timeValue2.toInt()));
        }
      });
    }
  }

  //// function to get city (from city.json file)
  getCity() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Consumer(builder: (BuildContext context, WidgetRef ref, _) {
          final cityHolder = ref.read(cityProvider);
          return FutureBuilder(
              future: cityHolder.readJsondata(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      ...cityHolder.cityList!.cities.map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {});
                                // here we are set value to the variable "selectedCityName"
                                cityHolder.selectedCityName = e.cityName;

                                //  cityHolder.getCity(e.cityName);
                                //
                                cityHolder.getEvents();
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppConfic.fontColor2
                                          .withOpacity(0.25)),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xffF5F6FA),
                                ),
                                child: Center(child: Text(e.cityName)),
                              ),
                            ),
                          ))
                    ]),
                  );
                }
              });
        });
      },
    );
  }

////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppConfic.backGroundColor,
          bottomNavigationBar:
              Consumer(builder: (BuildContext context, ref, _) {
            final cityHolder = ref.read(cityProvider);
            return GestureDetector(
              onTap: () async {
                await ref
                    .read(boatProviderChangeNotifier)
                    .searchFilter(cityHolder.selectedCityName.toString());
                //   searchFilter();
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return HomePage();
                //     },
                //   ),
                // );
                Navigator.pop(context);
                //setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 16),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppConfic.iconColor2,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                      child: Text(
                    SearchFilterTranslation.confirm,
                    style: TextStyle(
                        color: AppConfic.cardColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  )),
                ),
              ),
            );
          }),
          appBar: AppBar(
            backgroundColor: AppConfic.backGroundColor,
            automaticallyImplyLeading: false,
            title: Text(
              SearchFilterTranslation.filter,
              style: TextStyle(
                  fontSize: 18,
                  color: AppConfic.fontColor,
                  fontWeight: FontWeight.w700),
            ),
            leading: Consumer(builder: (BuildContext context, ref, _) {
              return IconButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_rounded));
            }),
          ),
          body: Consumer(builder: (context, ref, _) {
            final cityHolder = ref.read(cityProvider);
            final boatListHolder = ref.watch(boatProviderChangeNotifier);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/Location.svg',
                          width: 14.58,
                          height: 18.75,
                        ),
                        SizedBox(
                          width: 9,
                        ),
                        GestureDetector(
                          child: Text(
                            '  ${(cityHolder.selectedCityName != null) ? '${cityHolder.selectedCityName}' : SearchFilterTranslation.city}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppConfic.fontColor),
                          ),
                          onTap: () {
                            getCity();
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    cityHolder.cityEvents == null
                        ? SizedBox()
                        : Consumer(// here is to show events
                            builder: (BuildContext context, WidgetRef ref, _) {
                            final searchFilterState =
                                ref.watch(searchFilterProvider);
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ...cityHolder.cityEvents!.map(
                                    (element) => Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Container(
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: AppConfic.cardColor,
                                          //  color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Stack(
                                          children: [
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    setState(() {});
                                                    await cityHolder
                                                        .getSelectedEvent(
                                                            element);
                                                    await cityHolder
                                                        .getSelectedEventMinHours(
                                                            element);
                                                    searchFilterState
                                                            .timeValue2 =
                                                        element.minHours;
                                                    // timeNow2 = ////////////////////////////////////////////////////////////////////
                                                    //     timeNow1;
                                                    if (cityHolder
                                                            .selectedevent ==
                                                        null) {
                                                      timeNow2 = timeNow1.add(
                                                          Duration(hours: 1));
                                                    } else {
                                                      timeNow2 = timeNow1.add(
                                                          Duration(
                                                              hours:
                                                                  searchFilterState
                                                                      .timeValue2
                                                                      .toInt()));
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: cityHolder
                                                                .selectedevent ==
                                                            element.eventName
                                                        ? BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        8),
                                                                topRight: Radius
                                                                    .circular(
                                                                        8)),
                                                            border: Border.all(
                                                                width: 2,
                                                                color: Colors
                                                                    .green),
                                                          )
                                                        : null,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(8),
                                                              topRight: Radius
                                                                  .circular(8)),
                                                      child: Image.network(
                                                        height: 150,
                                                        width: 150,
                                                        element
                                                            .eventPhotos.first
                                                            .toString(),
                                                        fit: BoxFit.fill,
                                                        alignment:
                                                            Alignment.topCenter,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Center(
                                                  child: Text(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    element.eventName,
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                            cityHolder.selectedevent ==
                                                    element.eventName
                                                ? Positioned(
                                                    child: SvgPicture.asset(
                                                      'assets/Group 27.svg',
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    right: 8,
                                                    top: 8,
                                                  )
                                                : SizedBox(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      height: 56,
                      decoration: BoxDecoration(
                          color: AppConfic.cardColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                captain = true;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.44,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color:
                                    captain == true ? Color(0xffF5F6FA) : null,
                              ),
                              child: Center(
                                child:
                                    Text(SearchFilterTranslation.withCaptain),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                captain = false;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.44,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color:
                                    captain == false ? Color(0xffF5F6FA) : null,
                              ),
                              child: Center(
                                child: Text(
                                    SearchFilterTranslation.withoutCaptain),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    captain == false
                        ? Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppConfic.cardColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Availability of rights',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppConfic.fontColor2,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(height: 10),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            rights = true;
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(SearchFilterTranslation
                                                .norights),
                                            Spacer(),
                                            rights == true
                                                ? SvgPicture.asset(
                                                    'assets/Ellipse 83.svg',
                                                    color: Color(0xff19AE7A),
                                                  )
                                                : SvgPicture.asset(
                                                    'assets/Ellipse 83.svg',
                                                    color: Color(0xff808080)
                                                        .withOpacity(0.25),
                                                  ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Divider(),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            rights = false;
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(SearchFilterTranslation
                                                .havegimsrights),
                                            Spacer(),
                                            rights == false
                                                ? SvgPicture.asset(
                                                    'assets/Ellipse 83.svg',
                                                    color: Color(0xff19AE7A),
                                                  )
                                                : SvgPicture.asset(
                                                    'assets/Ellipse 83.svg',
                                                    color: Color(0xff808080)
                                                        .withOpacity(0.25),
                                                  ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              )
                            ],
                          )
                        : SizedBox(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppConfic.cardColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              SearchFilterTranslation.selectDT,
                              style: TextStyle(
                                  fontSize: 14, color: AppConfic.fontColor2),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Date',
                              style: TextStyle(
                                  fontSize: 14, color: AppConfic.fontColor2),
                            ),
                            SizedBox(height: 10),
                            Consumer(
                              builder: (context, ref, _) {
                                final searchFilterState =
                                    ref.watch(searchFilterProvider);
                                return GestureDetector(
                                  onTap: () {
                                    datePicker();
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "${timeNow1.day < 10 ? '0${timeNow1.day}' : timeNow1.day} - ${timeNow1.month < 10 ? '0${timeNow1.month}' : timeNow1.month} - ${timeNow1.year} ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: AppConfic.fontColor),
                                      ),
                                      Spacer(),
                                      SvgPicture.asset(
                                        'assets/Calendar.svg',
                                        width: 20,
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Divider(),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Start time',
                              style: TextStyle(
                                  fontSize: 14, color: AppConfic.fontColor2),
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                timePicker();
                              },
                              child: Row(
                                children: [
                                  Text(
                                    '${timeNow1.hour < 10 ? '0${timeNow1.hour}' : timeNow1.hour}:${timeNow1.minute < 10 ? '0${timeNow1.minute}' : timeNow1.minute}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppConfic.fontColor),
                                  ),
                                  Spacer(),
                                  SvgPicture.asset(
                                    'assets/Pen.svg',
                                    width: 20,
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    SearchFilterTranslation.duration,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppConfic.fontColor2),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Consumer(builder: (context, ref, _) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    SearchFilterTranslation.from,
                                    style: TextStyle(
                                        color: AppConfic.fontColor,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    '    ${timeNow1.hour < 10 ? '0${timeNow1.hour}' : timeNow1.hour}:${timeNow1.minute < 10 ? '0${timeNow1.minute}' : timeNow1.minute}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppConfic.fontColor),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    SearchFilterTranslation.to,
                                    style: TextStyle(),
                                  ),
                                  //userTimeNow2
                                  Text(
                                    '    ${timeNow2.hour < 10 ? '0${timeNow2.hour}' : timeNow2.hour}:${timeNow2.minute < 10 ? '0${timeNow2.minute}' : timeNow2.minute}',
                                    style: TextStyle(),
                                  ),
                                  Spacer(),
                                  Consumer(
                                    builder: (BuildContext context,
                                        WidgetRef ref, _) {
                                      final searchFilterState =
                                          ref.watch(searchFilterProvider);
                                      final cityHolder = ref.read(cityProvider);
                                      return IconButton(
                                        onPressed: () {
                                          //here we are checking if the
                                          if (cityHolder.selectedevent ==
                                              null) {
                                            if (searchFilterState.timeValue2 >
                                                1.0) {
                                              ref
                                                  .read(searchFilterProvider
                                                      .notifier)
                                                  .subtractTime();
                                              timeNow2 = timeNow2.subtract(
                                                Duration(minutes: 30),
                                              );
                                            }
                                          } else {
                                            //this is a condition in order to not decrease les than event time.
                                            if (searchFilterState.timeValue2 >
                                                cityHolder
                                                    .selectedeventMinHour!) {
                                              ref
                                                  .read(searchFilterProvider
                                                      .notifier)
                                                  .subtractTime();
                                              timeNow2 = timeNow2.subtract(
                                                Duration(minutes: 30),
                                              );
                                            }
                                          }
                                          setState(() {});
                                        },
                                        icon: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: AppConfic.iconColor),
                                          height: 32,
                                          width: 32,
                                          child: Center(
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),

                                  // here is decrease time button
                                  Consumer(
                                    builder: (BuildContext context,
                                        WidgetRef ref, _) {
                                      final searchFilterState =
                                          ref.watch(searchFilterProvider);
                                      return Text(
                                        // cityHolder.selectedeventMinHour == null
                                        //     ? " ${searchFilterState.timeValue2} "
                                        //     : cityHolder.selectedeventMinHour.toString(),
                                        "${searchFilterState.timeValue2}",
                                        style: TextStyle(fontSize: 16),
                                      );
                                    },
                                  ),
                                  // here is increase time button
                                  Consumer(builder:
                                      (BuildContext context, WidgetRef ref, _) {
                                    final searchFilterState =
                                        ref.watch(searchFilterProvider);
                                    return IconButton(
                                      onPressed: () {
                                        // this is a condition to make the maximum increasing 23 hours.
                                        if (searchFilterState.timeValue2 <
                                            23.0) {
                                          ref
                                              .watch(
                                                  searchFilterProvider.notifier)
                                              .addTime();

                                          timeNow2 = timeNow2.add(
                                            Duration(minutes: 30),
                                          );
                                          setState(() {});
                                        }
                                      },
                                      icon: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: AppConfic.iconColor),
                                        height: 32,
                                        width: 32,
                                        child: Center(
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                                ],
                              );
                            }),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppConfic.cardColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              SearchFilterTranslation.guests,
                              style: TextStyle(
                                  fontSize: 14, color: AppConfic.fontColor2),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  SearchFilterTranslation.adults,
                                  style: TextStyle(
                                      color: AppConfic.fontColor, fontSize: 16),
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    if (boatListHolder.adultsNumber > 1) {
                                      boatListHolder.adultsNumber =
                                          boatListHolder.adultsNumber - 1;
                                    }
                                    setState(() {});
                                  },
                                  icon: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: AppConfic.iconColor),
                                    height: 32,
                                    width: 32,
                                    child: Center(
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(' ${boatListHolder.adultsNumber} '),
                                IconButton(
                                  onPressed: () {
                                    boatListHolder.adultsNumber =
                                        boatListHolder.adultsNumber + 1;
                                    setState(() {});
                                  },
                                  icon: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: AppConfic.iconColor),
                                    height: 32,
                                    width: 32,
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  SearchFilterTranslation.children,
                                  style: TextStyle(
                                      color: AppConfic.fontColor, fontSize: 16),
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    if (boatListHolder.childrenNumber > 0) {
                                      boatListHolder.childrenNumber =
                                          boatListHolder.childrenNumber - 1;
                                    }
                                    setState(() {});
                                  },
                                  icon: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: AppConfic.iconColor),
                                    height: 32,
                                    width: 32,
                                    child: Center(
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(' ${boatListHolder.childrenNumber} '),
                                IconButton(
                                  onPressed: () {
                                    boatListHolder.childrenNumber =
                                        boatListHolder.childrenNumber + 1;
                                    setState(() {});
                                  },
                                  icon: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: AppConfic.iconColor),
                                    height: 32,
                                    width: 32,
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppConfic.cardColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Other options',
                              style: TextStyle(
                                  fontSize: 14, color: AppConfic.fontColor2),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  pets = !pets;
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    SearchFilterTranslation.pets,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Spacer(),
                                  pets == true
                                      ? SvgPicture.asset(
                                          'assets/greenbuttom.svg',
                                          width: 22,
                                          height: 22,
                                        )
                                      : SvgPicture.asset(
                                          'assets/outlinebutton.svg',
                                          width: 22,
                                          height: 22,
                                        )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  disabilities = !disabilities;
                                });
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      SearchFilterTranslation.disabilities,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  // Spacer(),
                                  disabilities == true
                                      ? SvgPicture.asset(
                                          'assets/greenbuttom.svg',
                                          width: 22,
                                          height: 22,
                                        )
                                      : SvgPicture.asset(
                                          'assets/outlinebutton.svg',
                                          width: 22,
                                          height: 22,
                                        )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    )
                  ],
                ),
              ),
            );
          })),
    );
  }
}
