import 'package:design/whereToDesign/models/boat_model.dart';
import 'package:design/whereToDesign/providers/city_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

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
      timeNow2 = timeNow1
          .add(Duration(hours: searchFilterState.timeValue2.toInt() + 1));
    }
    super.initState();
  }

  dateTimePicker() async {
    final searchFilterState = ref.watch(searchFilterProvider);
    final cityHolder = ref.read(cityProvider);
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime.now(),
        lastDate: DateTime(3030));
    setState(() {
      if (dateTime != null) {
        timeNow1 = dateTime;
      }
    });

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
                                child: Text(e.cityName)),
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton:
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
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF8942BC),
                      Color(0xFF5831F7),
                      Color(0xFF5731F8),
                      Color(0xFF00C2C2),
                    ],
                  ),
                  border: GradientBoxBorder(
                    width: 2,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF8942BC),
                        Color(0xFF5831F7),
                        Color(0xFF5731F8),
                        Color(0xFF00C2C2),
                      ],
                    ),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                    child: Text(
                  SearchFilterTranslation.apply,
                  style: TextStyle(),
                )),
              ),
            );
          }),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(SearchFilterTranslation.filter),
            centerTitle: true,
            leading: Consumer(builder: (BuildContext context, ref, _) {
              return IconButton(
                  onPressed: () async {
                    // if (ref.read(boatProviderChangeNotifier).filterList !=
                    //     null) {
                    //   ref.read(boatProviderChangeNotifier).filterList!.clear();
                    // }
                    //
                    //
                    // if (ref.read(cityProvider).selectedCityName != null) {
                    //   ref.read(cityProvider).selectedCityName = null;
                    // }
                    // if (ref.read(cityProvider).cityEvents != null) {
                    //   ref.read(cityProvider).cityEvents = null;
                    // }
                    // if (ref.read(boatProviderChangeNotifier).selectedCityV !=
                    //     null) {
                    //   ref.read(boatProviderChangeNotifier).selectedCityV = null;
                    // }
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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_city_outlined),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          child: Text(
                              '  ${(cityHolder.selectedCityName != null) ? '${cityHolder.selectedCityName}' : SearchFilterTranslation.city}'),
                          // Text(
                          //     '  ${(cityHolder.selectedCityName == null && boatListHolder.selectedCityV != null) ? '${boatListHolder.selectedCityV}' : (cityHolder.selectedCityName != null && boatListHolder.selectedCityV == null) ? cityHolder.selectedCityName : (cityHolder.selectedCityName != null && boatListHolder.selectedCityV != null && cityHolder.selectedCityName == boatListHolder.selectedCityV) ? 'both are not null Chutia' : SearchFilterTranslation.city}'),
                          onTap: () {
                            getCity();
                          },
                        )
                      ],
                    ),
                    cityHolder.cityEvents == null
                        ? SizedBox()
                        : Consumer(
                            builder: (BuildContext context, WidgetRef ref, _) {
                            final searchFilterState =
                                ref.watch(searchFilterProvider);
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...cityHolder.cityEvents!.map((element) =>
                                      Stack(
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: GestureDetector(
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
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            border: Border.all(
                                                                width: 2,
                                                                color: Colors
                                                                    .green),
                                                          )
                                                        : null,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: Image.network(
                                                        height: 100,
                                                        width: 100,
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
                                              ),
                                              SizedBox(
                                                width: 100,
                                                child: Text(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    element.eventName),
                                              )
                                            ],
                                          ),
                                          cityHolder.selectedevent ==
                                                  element.eventName
                                              ? Positioned(
                                                  child: Icon(
                                                    Icons.check_circle_outline,
                                                    color: Colors.green,
                                                  ),
                                                  right: 8,
                                                  top: 8,
                                                )
                                              : SizedBox(),
                                        ],
                                      ))
                                ],
                              ),
                            );
                          }),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              captain = true;
                            });
                          },
                          child: Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width * 0.45,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2),
                              borderRadius: BorderRadius.circular(5),
                              color: captain == true ? Colors.green : null,
                            ),
                            child: Center(
                              child: Text(SearchFilterTranslation.withCaptain),
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
                            height: 30,
                            width: MediaQuery.of(context).size.width * 0.45,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2),
                              borderRadius: BorderRadius.circular(5),
                              color: captain == false ? Colors.green : null,
                            ),
                            child: Center(
                              child:
                                  Text(SearchFilterTranslation.withoutCaptain),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    captain == false
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    rights = true;
                                  });
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      rights == true
                                          ? Icon(Icons
                                              .radio_button_checked_rounded)
                                          : Icon(Icons.circle_outlined),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(SearchFilterTranslation
                                          .withoutLicense)
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    rights = false;
                                  });
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      rights == false
                                          ? Icon(Icons
                                              .radio_button_checked_rounded)
                                          : Icon(Icons.circle_outlined),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(SearchFilterTranslation.withLicense)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      SearchFilterTranslation.selectDT,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Consumer(builder: (context, ref, _) {
                      final searchFilterState = ref.watch(searchFilterProvider);
                      return GestureDetector(
                        onTap: () {
                          dateTimePicker();
                        },
                        child: Text(
                          "${timeNow1.day}-${timeNow1.month}-${timeNow1.year} (${timeNow1.hour}:${timeNow1.minute})",
                          style: TextStyle(),
                        ),
                      );
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            SearchFilterTranslation.duration,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Consumer(
                            builder: (BuildContext context, WidgetRef ref, _) {
                          final searchFilterState =
                              ref.watch(searchFilterProvider);
                          final cityHolder = ref.read(cityProvider);
                          return IconButton(
                            onPressed: () {
                              //here we are checking if the
                              if (cityHolder.selectedevent == null) {
                                if (searchFilterState.timeValue2 > 1.0) {
                                  ref
                                      .read(searchFilterProvider.notifier)
                                      .subtractTime();
                                  timeNow2 = timeNow2.subtract(
                                    Duration(minutes: 30),
                                  );
                                }

                                // timeNow2 = timeNow2.add(
                                //   Duration(minutes: 30),
                                // );
                              } else {
                                //this is a condition in order to not decrease les than event time.
                                if (searchFilterState.timeValue2 >
                                    cityHolder.selectedeventMinHour!) {
                                  ref
                                      .read(searchFilterProvider.notifier)
                                      .subtractTime();
                                  timeNow2 = timeNow2.subtract(
                                    Duration(minutes: 30),
                                  );
                                }
                              }
                            },
                            icon: Icon(
                              Icons.remove,
                              //color: Colors.black,
                            ),
                          );
                        }),
                        Consumer(
                            builder: (BuildContext context, WidgetRef ref, _) {
                          final searchFilterState =
                              ref.watch(searchFilterProvider);
                          return Text(
                            // cityHolder.selectedeventMinHour == null
                            //     ? " ${searchFilterState.timeValue2} "
                            //     : cityHolder.selectedeventMinHour.toString(),
                            " ${searchFilterState.timeValue2} ",
                            style: TextStyle(fontSize: 20),
                          );
                        }),
                        Consumer(
                            builder: (BuildContext context, WidgetRef ref, _) {
                          final searchFilterState =
                              ref.watch(searchFilterProvider);
                          return IconButton(
                            onPressed: () {
                              // this is a condition to make the maximum increasing 23 hours.
                              if (searchFilterState.timeValue2 < 23.0) {
                                ref
                                    .watch(searchFilterProvider.notifier)
                                    .addTime();

                                timeNow2 = timeNow2.add(
                                  Duration(minutes: 30),
                                );
                                setState(() {});
                              }
                            },
                            icon: Icon(
                              Icons.add,
                            ),
                          );
                        })
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
                                //color: Colors.black,
                                ),
                          ),
                          Text(
                            '    ${timeNow1.hour < 10 ? '0${timeNow1.hour}' : timeNow1.hour}:${timeNow1.minute < 10 ? '0${timeNow1.minute}' : timeNow1.minute}',
                            style: TextStyle(),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 20,
                          ),
                          Text(
                            SearchFilterTranslation.to,
                            style: TextStyle(),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 20,
                          ), //userTimeNow2
                          Text(
                            '    ${timeNow2.hour < 10 ? '0${timeNow2.hour}' : timeNow2.hour}:${timeNow2.minute < 10 ? '0${timeNow2.minute}' : timeNow2.minute}',
                            style: TextStyle(),
                          ),
                        ],
                      );
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      SearchFilterTranslation.guests,
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(SearchFilterTranslation.adults),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            if (boatListHolder.adultsNumber > 1) {
                              boatListHolder.adultsNumber =
                                  boatListHolder.adultsNumber - 1;
                            }
                            setState(() {});
                          },
                          icon: Icon(Icons.remove),
                        ),
                        Text(' ${boatListHolder.adultsNumber} '),
                        IconButton(
                          onPressed: () {
                            boatListHolder.adultsNumber =
                                boatListHolder.adultsNumber + 1;
                            setState(() {});
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(SearchFilterTranslation.children),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            if (boatListHolder.childrenNumber > 0) {
                              boatListHolder.childrenNumber =
                                  boatListHolder.childrenNumber - 1;
                            }
                            setState(() {});
                          },
                          icon: Icon(Icons.remove),
                        ),
                        Text(' ${boatListHolder.childrenNumber} '),
                        IconButton(
                          onPressed: () {
                            boatListHolder.childrenNumber =
                                boatListHolder.childrenNumber + 1;
                            setState(() {});
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
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
                              ? Icon(Icons.check_box)
                              : Icon(Icons.check_box_outline_blank)
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
                              ? Icon(Icons.check_box)
                              : Icon(Icons.check_box_outline_blank)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 300,
                    ),
                  ],
                ),
              ),
            );
          })),
    );
  }
}
