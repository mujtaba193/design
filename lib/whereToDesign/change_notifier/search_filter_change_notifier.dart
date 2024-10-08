import 'package:design/whereToDesign/models/boat_model.dart';
import 'package:design/whereToDesign/providers/city_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../providers/filter/search_filter_provider.dart';
import '../translation/search_filter_translation.dart';
import 'boat_provider_change_notifire.dart';

class SearchFilterChangeNotifier extends StatefulWidget {
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
  State<SearchFilterChangeNotifier> createState() =>
      _SearchFilterChangeNotifierState();
}

class _SearchFilterChangeNotifierState
    extends State<SearchFilterChangeNotifier> {
  TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  //double timeValue = 1.0;
  double timeValue2 = 1.0;

  DateTime userTimeNow1 = DateTime.now().toLocal();
  DateTime userTimeNow2 = DateTime.now().toLocal();
  DateTime date = DateTime.now().toLocal();
  /////////////////////////city///////////////////////////
  List<String> cityList = [];
  List<String> cityNameList = [];
  String? selectedCity;
  String? selectedCityName;
  // List<Event>? cityEvents;
  // String? slectedevent;
  bool? captain;
  bool? rights;
  bool pets = false;
  bool disabilities = false;

  @override
  void initState() {
    userTimeNow2 = userTimeNow1.add(Duration(hours: 1));

    //  listCities();
    super.initState();
  }

  dateTimePicker() async {
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime.now(),
        lastDate: DateTime(3030));
    setState(() {
      if (dateTime != null) {
        userTimeNow1 = dateTime;
      }
    });

    TimeOfDay? timeOfDay =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (timeOfDay != null) {
      setState(() {
        userTimeNow1 = userTimeNow1
            .add(Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute));
        userTimeNow2 = userTimeNow1.add(Duration(hours: 1));
      });
    }
  }

  // listCities() async {
  //  final cityHolder = ref.read(cityProvider);
  //  await cityHolder.readJsondata();
  // }

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
                                  // selectedCityName = e.cityName.toString();
                                  cityHolder.getCity(e.cityName);
                                  selectedCityName =
                                      cityHolder.selectedCityName;
                                  // for (var varr
                                  //     in cityHolder.cityList!.cities) {
                                  //   if (selectedCityName == varr.cityName) {
                                  //     cityEvents = varr.events;
                                  //   }
                                  // }
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
            return GestureDetector(
              onTap: () async {
                await ref
                    .read(boatProviderChangeNotifier)
                    .searchFilter(selectedCityName);
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
                    if (ref.read(boatProviderChangeNotifier).filterList !=
                        null) {
                      ref.read(boatProviderChangeNotifier).filterList!.clear();
                    }
                    if (ref.read(cityProvider).selectedCityName != null) {
                      ref.read(cityProvider).selectedCityName = null;
                    }
                    if (ref.read(cityProvider).cityEvents != null) {
                      ref.read(cityProvider).cityEvents = null;
                    }
                    if (ref.read(boatProviderChangeNotifier).selectedCityV !=
                        null) {
                      ref.read(boatProviderChangeNotifier).selectedCityV = null;
                    }
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_rounded));
            }),
          ),
          body: Consumer(builder: (context, ref, _) {
            final cityHolder = ref.read(cityProvider);
            final boatListHolder = ref.read(boatProviderChangeNotifier);
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
                              '  ${(cityHolder.selectedCityName == null && boatListHolder.selectedCityV != null) ? '${boatListHolder.selectedCityV}' : (cityHolder.selectedCityName != null && boatListHolder.selectedCityV == null) ? cityHolder.selectedCityName : (cityHolder.selectedCityName != null && boatListHolder.selectedCityV != null) ? 'both are not null Chutia' : SearchFilterTranslation.city}'),
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
                                                  },
                                                  child: Container(
                                                    decoration: cityHolder
                                                                .slectedevent ==
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
                                          cityHolder.slectedevent ==
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
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        dateTimePicker();
                      },
                      child: Text(
                        "${userTimeNow1.day}-${userTimeNow1.month}-${userTimeNow1.year} (${userTimeNow1.hour}:${userTimeNow1.minute})",
                        style: TextStyle(),
                      ),
                    ),
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
                          return IconButton(
                            onPressed: () {
                              ref
                                  .read(searchFilterProvider.notifier)
                                  .subtractTime();
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
                            " ${searchFilterState.timeValue2} ",
                            style: TextStyle(fontSize: 20),
                          );
                        }),
                        Consumer(
                            builder: (BuildContext context, WidgetRef ref, _) {
                          return IconButton(
                            onPressed: () {
                              ref.read(searchFilterProvider.notifier).addTime();
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          SearchFilterTranslation.from,
                          style: TextStyle(
                              //color: Colors.black,
                              ),
                        ),
                        Text(
                          '    ${userTimeNow1.hour < 10 ? '0${userTimeNow1.hour}' : userTimeNow1.hour}:${userTimeNow1.minute < 10 ? '0${userTimeNow1.minute}' : userTimeNow1.minute}',
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
                        ),
                      ],
                    ),
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
                        Text(SearchFilterTranslation.aduls),
                        Spacer(),
                        Text('+ 3 -'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(SearchFilterTranslation.children),
                        Spacer(),
                        Text('+ 3 -'),
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
