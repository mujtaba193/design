import 'package:design/whereToDesign/models/boat_model.dart';
import 'package:design/whereToDesign/providers/city_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../home_page.dart';
import '../models/events_model.dart';
import '../providers/bout_provider.dart';
import '../providers/filter/search_filter_provider.dart';
import '../translation/search_filter_translation.dart';

class SearchFilter extends StatefulWidget {
  List<BoatModel>? boatList;
  final BoatModel? boatinfo;
  bool? isSearch;
  SearchFilter({
    Key? key,
    this.boatList,
    this.isSearch,
    this.boatinfo,
  }) : super(key: key);

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
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
  List<Event>? cityEvents;
  String? slectedevent;
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
                                  selectedCityName = e.cityName.toString();
                                  for (var varr
                                      in cityHolder.cityList!.cities) {
                                    if (selectedCityName == varr.cityName) {
                                      setState(() {
                                        cityEvents = varr.events;
                                      });
                                    }
                                  }

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

  // cheackBookTime() {
  //   if (userTimeNow2.isBefore(widget.boatinfo!.bookedStartTime) == false &&
  //       userTimeNow1.isAfter(widget.boatinfo!.bookedFinishTime) == false) {
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return Dialog(
  //             child: Container(
  //                 height: 50,
  //                 child: Center(
  //                     child: Text('Already booked pls select another time'))),
  //           );
  //         });
  //   }
  // }

  // filterBoat() {
  //   if (widget.boatList != null) {
  //     for (var varia in widget.boatList!) {
  //       if ((userTimeNow2.isBefore(varia.bookedStartTime) ||
  //               userTimeNow1.isAfter(varia.bookedFinishTime)) &&
  //           varia.city == selectedCity) {
  //         newBoatList.add(varia);
  //       }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton:
              Consumer(builder: (BuildContext context, ref, _) {
            return GestureDetector(
              onTap: () {
                ref.read(boutProvider).searchFilter(selectedCityName);
                //  searchFilter();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return HomePage(
                          searchFilterList:
                              ref.read(boutProvider).searchFilterList!,
                          searchValue: ref.read(boutProvider).searchValue);
                    },
                  ),
                );
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
                  //color: Colors.grey.withOpacity(0.5),
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
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_rounded)),
          ),
          body:
              // FutureBuilder(
              //     future: cityHolder.readJsondata(),
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return const CircularProgressIndicator();
              //       } else {
              //         return
              SingleChildScrollView(
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
                            '${selectedCityName == null ? SearchFilterTranslation.city : selectedCityName}'),
                        onTap: () {
                          getCity();
                        },
                      )
                    ],
                  ),
                  cityEvents == null
                      ? SizedBox()
                      : Consumer(
                          builder: (BuildContext context, WidgetRef ref, _) {
                          // final searchProv = ref.watch(searchFilterProvider);
                          final boatHolder = ref.read(boutProvider);
                          final cityHolder = ref.read(cityProvider);
                          return Container(
                            height: 140,
                            child: ListView.builder(
                                key: PageStorageKey(2),
                                scrollDirection: Axis.horizontal,
                                itemCount: cityEvents!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Stack(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  slectedevent =
                                                      cityEvents![index]
                                                          .eventName;
                                                });
                                              },
                                              child: Container(
                                                decoration: slectedevent ==
                                                        cityEvents![index]
                                                            .eventName
                                                    ? BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            width: 2,
                                                            color:
                                                                Colors.green),
                                                      )
                                                    : null,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: Image.network(
                                                    height: 100,
                                                    width: 100,
                                                    cityEvents![index]
                                                        .eventPhotos
                                                        .first
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
                                                overflow: TextOverflow.ellipsis,
                                                cityEvents![index].eventName),
                                          )
                                        ],
                                      ),
                                      slectedevent ==
                                              cityEvents![index].eventName
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
                                  );
                                }),
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
                            child: Text(SearchFilterTranslation.withoutCaptain),
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
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    rights == true
                                        ? Icon(
                                            Icons.radio_button_checked_rounded)
                                        : Icon(Icons.circle_outlined),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(SearchFilterTranslation.withoutLicense)
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
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    rights == false
                                        ? Icon(
                                            Icons.radio_button_checked_rounded)
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
                            // setState(() {
                            //   if (timeValue2 > 1.0) {
                            //     timeValue2 = timeValue2 - 0.5;
                            //     userTimeNow2 = userTimeNow2.subtract(
                            //       Duration(minutes: 30),
                            //     );
                            //   }
                            // });
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
                            // setState(() {
                            //   timeValue2 = timeValue2 + 0.5;
                            //   userTimeNow2 = userTimeNow2.add(
                            //     Duration(minutes: 30),
                            //   );
                            // });
                            // ref.read(searchProv.addTime());

                            ref.read(searchFilterProvider.notifier).addTime();
                          },
                          icon: Icon(
                            Icons.add,
                            //color: Colors.black,
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
                      //   Text(
                      //   '${searchFilterState.userTimeNow2.hour < 10 ? '0${searchFilterState.userTimeNow2.hour}' : searchFilterState.userTimeNow2.hour}:${searchFilterState.userTimeNow2.minute < 10 ? '0${searchFilterState.userTimeNow2.minute}' : searchFilterState.userTimeNow2.minute}',
                      //    style: TextStyle(),
                      //   )
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
          )),
    );
  }
}
