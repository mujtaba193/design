import 'package:design/whereToDesign/models/boat_model.dart';
import 'package:design/whereToDesign/show_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../filter/search_filter.dart';
import '../providers/bout_provider.dart';
import '../translation/filter_translation.dart';

class ReviewFilter extends ConsumerStatefulWidget {
  // List<BoatModel> filterList;
  bool searchValue;
  List<BoatModel>? searchFilterList;
  DateTime? userTimeNow1;
  DateTime? userTimeNow2;
  ReviewFilter(
      {super.key,
      this.userTimeNow1,
      this.userTimeNow2,
      this.searchFilterList,
      required this.searchValue
      // required this.filterList
      });

  @override
  ConsumerState<ReviewFilter> createState() => _Review2State();
}

class _Review2State extends ConsumerState<ReviewFilter> {
  double startPrice = 1;
  double endPrice = 10000;
  double startLength = 1;
  double endLength = 10000;
  double startRating = 1;
  double endRating = 5;
  int? shipType;
  int? toilet;
  bool? rainValue;
  bool? bimini;
  bool? bluetooth;
  bool? mask;
  bool? shower;
  bool? fridge;
  bool? blankets;
  bool? table;
  bool? glasses;
  bool? bathing;
  bool? fishEcho;
  bool? heater;
  bool? climate;

  List<String> list = [
    FilterPageTranslation.highspeed,
    FilterPageTranslation.american,
    FilterPageTranslation.slowMoving,
    FilterPageTranslation.retro,
    FilterPageTranslation.closed,
    FilterPageTranslation.withFlybridge,
    FilterPageTranslation.withPanoramicWindows
  ];
  List<String> selectedlist = [];
  List<BoatModel>? filterList;
  String? theShipTypeValue;
  String? theToiletValue;
  bool filterValue = false;
  @override
  void initState() {
    filter();
    super.initState();
  }

  filter() async {
    final boatListHolder = ref.read(boutProvider);
    if (widget.searchFilterList == null ||
        widget.searchFilterList!.isEmpty == true) {
      await boatListHolder.readJsondata();
    }
    final boatList = (widget.searchFilterList == null ||
            widget.searchFilterList!.isEmpty == true)
        ? boatListHolder.boatList
        : widget.searchFilterList!;
    filterList = boatList!
        .where((element) =>
            (element.finalPrice >= startPrice &&
                element.finalPrice <= endPrice) &&
            (element.characteristics.length >= startLength &&
                element.characteristics.length <= endLength) &&
            (element.rating >= startRating && element.rating <= endRating) &&
            (shipType == null || element.shipType == theShipTypeValue) &&
            (toilet == null || element.toiletOnBoard == theToiletValue) &&
            (rainValue != null
                ? element.characteristics.rain_awning == rainValue
                : true) &&
            (bimini != null
                ? element.characteristics.bimini_sunshade == bimini
                : true) &&
            (bluetooth != null
                ? element.characteristics.bluetooth_audio_system == bluetooth
                : true) &&
            (mask != null
                ? element.characteristics.snorkeling_mask == mask
                : true) &&
            (shower != null
                ? element.characteristics.shower == shower
                : true) &&
            (fridge != null
                ? element.characteristics.fridge == fridge
                : true) &&
            (blankets != null
                ? element.characteristics.blankets == blankets
                : true) &&
            (table != null ? element.characteristics.table == table : true) &&
            (glasses != null
                ? element.characteristics.glasses == glasses
                : true) &&
            (bathing != null
                ? element.characteristics.bathing_platform == bathing
                : true) &&
            (fishEcho != null
                ? element.characteristics.fish_echo_sounder == fishEcho
                : true) &&
            (heater != null
                ? element.characteristics.heater == heater
                : true) &&
            (climate != null
                ? element.characteristics.climate_control == climate
                : true) &&
            (selectedlist.contains(FilterPageTranslation.highspeed)
                ? element.features.highSpeed ==
                    selectedlist.contains(FilterPageTranslation.highspeed)
                : true) &&
            (selectedlist.contains(FilterPageTranslation.american)
                ? element.features.american ==
                    selectedlist.contains(FilterPageTranslation.american)
                : true) &&
            (selectedlist.contains(FilterPageTranslation.slowMoving)
                ? element.features.slowMoving ==
                    selectedlist.contains(FilterPageTranslation.slowMoving)
                : true) &&
            (selectedlist.contains(FilterPageTranslation.retro)
                ? element.features.retro ==
                    selectedlist.contains(FilterPageTranslation.retro)
                : true) &&
            (selectedlist.contains(FilterPageTranslation.closed)
                ? element.features.closed ==
                    selectedlist.contains(FilterPageTranslation.closed)
                : true) &&
            (selectedlist.contains(FilterPageTranslation.withFlybridge)
                ? element.features.withFlybridge ==
                    selectedlist.contains(FilterPageTranslation.withFlybridge)
                : true) &&
            (selectedlist.contains(FilterPageTranslation.withPanoramicWindows)
                ? element.features.withPanoramicWindows ==
                    selectedlist
                        .contains(FilterPageTranslation.withPanoramicWindows)
                : true))
        .toList();

    setState(() {});
  }

  rest() {
    setState(() {
      startPrice = 1;
      endPrice = 10000;
      startLength = 1;
      endLength = 10000;
      startRating = 1;
      endRating = 5;
      shipType = null;
      toilet = null;
      rainValue = null;
      bimini = null;
      bluetooth = null;
      mask = null;
      shower = null;
      fridge = null;
      blankets = null;
      table = null;
      glasses = null;
      bathing = null;
      fishEcho = null;
      heater = null;
      climate = null;
      selectedlist = [];
      filterList = [];
      filterValue = false;
      filterList = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final boatListHolder = ref.read(boutProvider);
    final boatList = boatListHolder.boatList;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder(
            future: boatListHolder.readJsondata(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          height: 60,
                          margin: EdgeInsets.all(10),
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
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:
                              // (filterList == null)
                              //     ?
                              Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                      return SearchFilter(
                                          boatList: boatListHolder.boatList);
                                    }),
                                  );
                                },
                                child: Text('Search'),
                              ),
                              Spacer(),
                              TextButton(
                                child: Text('Filter'),
                                onPressed: () {
                                  showModalBottomSheet(
                                    useSafeArea: true,
                                    // showDragHandle: true,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                        builder: (context, setState) {
                                          final boatListHolder =
                                              ref.read(boutProvider);
                                          final boatList =
                                              boatListHolder.boatList;
                                          return Scaffold(
                                            appBar: AppBar(
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      rest();
                                                    });
                                                  },
                                                  child: Text('Rreset'),
                                                ),
                                              ],
                                              centerTitle: true,
                                              title: Text(
                                                  FilterPageTranslation.filter),
                                              automaticallyImplyLeading: false,
                                              leading: IconButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                icon: Icon(Icons.close_rounded),
                                              ),
                                            ),
                                            body: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              padding: EdgeInsets.all(10),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Stack(
                                                children: [
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          FilterPageTranslation
                                                              .price,
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                                '${FilterPageTranslation.from} ${startPrice.toStringAsFixed(2)} ₽'),
                                                            Spacer(),
                                                            Text(
                                                                '${FilterPageTranslation.to} ${endPrice.toStringAsFixed(2)} ₽'),
                                                          ],
                                                        ),
                                                        RangeSlider(
                                                            min: 1,
                                                            max: 10000,
                                                            values: RangeValues(
                                                                startPrice,
                                                                endPrice),
                                                            onChanged:
                                                                (RangeValues
                                                                    values) {
                                                              setState(() {
                                                                startPrice =
                                                                    values
                                                                        .start;
                                                                endPrice =
                                                                    values.end;
                                                              });
                                                            }),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Text(
                                                          FilterPageTranslation
                                                              .length,
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                                '${FilterPageTranslation.from} ${startLength.toStringAsFixed(2)} M'),
                                                            Spacer(),
                                                            Text(
                                                                '${FilterPageTranslation.to} ${endLength.toStringAsFixed(2)} M')
                                                          ],
                                                        ),
                                                        RangeSlider(
                                                            min: 1,
                                                            max: 10000,
                                                            values: RangeValues(
                                                                startLength,
                                                                endLength),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                startLength =
                                                                    value.start;
                                                                endLength =
                                                                    value.end;
                                                              });
                                                            }),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Text(
                                                          FilterPageTranslation
                                                              .rating,
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                                '${FilterPageTranslation.from} ${startRating.toStringAsFixed(1)} '),
                                                            Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.yellow,
                                                            ),
                                                            Spacer(),
                                                            Text(
                                                                '${FilterPageTranslation.to} ${endRating.toStringAsFixed(1)} '),
                                                            Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.yellow,
                                                            ),
                                                          ],
                                                        ),
                                                        RangeSlider(
                                                            min: 1,
                                                            max: 5,
                                                            values: RangeValues(
                                                                startRating,
                                                                endRating),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                startRating =
                                                                    value.start;
                                                                endRating =
                                                                    value.end;
                                                              });
                                                            }),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Text(
                                                          FilterPageTranslation
                                                              .type,
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                        Wrap(
                                                          spacing: 15.0,
                                                          children: List<
                                                              Widget>.generate(
                                                            2,
                                                            (int index) {
                                                              return ChoiceChip(
                                                                selectedColor:
                                                                    Color(
                                                                        0xFF5731F8),
                                                                disabledColor:
                                                                    Color(
                                                                        0xFF8942BC),
                                                                label: Text(
                                                                    ' ${index == 0 ? FilterPageTranslation.motor : FilterPageTranslation.sailing}'),
                                                                selected:
                                                                    shipType ==
                                                                        index,
                                                                onSelected: (bool
                                                                    selected) {
                                                                  setState(() {
                                                                    shipType =
                                                                        selected
                                                                            ? index
                                                                            : null;
                                                                    if (shipType ==
                                                                        0) {
                                                                      theShipTypeValue =
                                                                          'Motor';
                                                                    } else if (shipType ==
                                                                        1) {
                                                                      theShipTypeValue =
                                                                          'Sailing';
                                                                    }
                                                                  });
                                                                },
                                                              );
                                                            },
                                                          ).toList(),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Text(
                                                          FilterPageTranslation
                                                              .toilet,
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                        Wrap(
                                                          spacing: 10.0,
                                                          children: List<
                                                              Widget>.generate(
                                                            3,
                                                            (int index) {
                                                              return ChoiceChip(
                                                                selectedColor:
                                                                    Color(
                                                                        0xFF5731F8),
                                                                disabledColor:
                                                                    Color(
                                                                        0xFF8942BC),
                                                                label: Text(
                                                                    ' ${index == 0 ? FilterPageTranslation.notImportant : index == 1 ? FilterPageTranslation.yes : FilterPageTranslation.no}'),
                                                                selected:
                                                                    toilet ==
                                                                        index,
                                                                onSelected: (bool
                                                                    selected) {
                                                                  setState(() {
                                                                    toilet = selected
                                                                        ? index
                                                                        : null;
                                                                    if (toilet ==
                                                                        0) {
                                                                      theToiletValue =
                                                                          'Not important';
                                                                    } else if (toilet ==
                                                                        1) {
                                                                      theToiletValue =
                                                                          'Yes';
                                                                    } else if (toilet ==
                                                                        2) {
                                                                      theToiletValue =
                                                                          'No';
                                                                    }
                                                                  });
                                                                },
                                                              );
                                                            },
                                                          ).toList(),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Text(
                                                          FilterPageTranslation
                                                              .amenities,
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10.0),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(FilterPageTranslation
                                                                      .rain),
                                                                  Spacer(),
                                                                  CupertinoSwitch(
                                                                    value:
                                                                        rainValue ??
                                                                            false,
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        rainValue =
                                                                            value;
                                                                      });
                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(FilterPageTranslation
                                                                      .biminiSunshade),
                                                                  Spacer(),
                                                                  CupertinoSwitch(
                                                                    value:
                                                                        bimini ??
                                                                            false,
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        bimini =
                                                                            value;
                                                                      });
                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(FilterPageTranslation
                                                                      .bluetooth),
                                                                  Spacer(),
                                                                  CupertinoSwitch(
                                                                    value:
                                                                        bluetooth ??
                                                                            false,
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        bluetooth =
                                                                            value;
                                                                      });
                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(FilterPageTranslation
                                                                      .snorkeling),
                                                                  Spacer(),
                                                                  CupertinoSwitch(
                                                                    value: mask ??
                                                                        false,
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        mask =
                                                                            value;
                                                                      });
                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(FilterPageTranslation
                                                                      .shower),
                                                                  Spacer(),
                                                                  CupertinoSwitch(
                                                                    value:
                                                                        shower ??
                                                                            false,
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        shower =
                                                                            value;
                                                                      });
                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(FilterPageTranslation
                                                                      .fridge),
                                                                  Spacer(),
                                                                  CupertinoSwitch(
                                                                    value:
                                                                        fridge ??
                                                                            false,
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        fridge =
                                                                            value;
                                                                      });
                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(FilterPageTranslation
                                                                      .blankets),
                                                                  Spacer(),
                                                                  CupertinoSwitch(
                                                                    value:
                                                                        blankets ??
                                                                            false,
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        blankets =
                                                                            value;
                                                                      });
                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(FilterPageTranslation
                                                                      .table),
                                                                  Spacer(),
                                                                  CupertinoSwitch(
                                                                    value:
                                                                        table ??
                                                                            false,
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        table =
                                                                            value;
                                                                      });
                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(FilterPageTranslation
                                                                      .glasses),
                                                                  Spacer(),
                                                                  CupertinoSwitch(
                                                                    value:
                                                                        glasses ??
                                                                            false,
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        glasses =
                                                                            value;
                                                                      });
                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                      'Bathing platform'),
                                                                  Spacer(),
                                                                  CupertinoSwitch(
                                                                    value:
                                                                        bathing ??
                                                                            false,
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        bathing =
                                                                            value;
                                                                      });
                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(FilterPageTranslation
                                                                      .fishEcho),
                                                                  Spacer(),
                                                                  CupertinoSwitch(
                                                                    value:
                                                                        fishEcho ??
                                                                            false,
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        fishEcho =
                                                                            value;
                                                                      });
                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(FilterPageTranslation
                                                                      .heater),
                                                                  Spacer(),
                                                                  CupertinoSwitch(
                                                                    value:
                                                                        heater ??
                                                                            false,
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        heater =
                                                                            value;
                                                                      });
                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(FilterPageTranslation
                                                                      .climate),
                                                                  Spacer(),
                                                                  CupertinoSwitch(
                                                                    value:
                                                                        climate ??
                                                                            false,
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        climate =
                                                                            value;
                                                                      });
                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 40,
                                                        ),
                                                        Text(
                                                          FilterPageTranslation
                                                              .features,
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 8.0),
                                                          child: Wrap(
                                                            spacing: 15.0,
                                                            children: list
                                                                .map(
                                                                  (e) =>
                                                                      ChoiceChip(
                                                                    selectedColor:
                                                                        Color(
                                                                            0xFF5731F8),
                                                                    disabledColor:
                                                                        Color(
                                                                            0xFF8942BC),
                                                                    label:
                                                                        Text(e),
                                                                    selected: selectedlist
                                                                        .contains(
                                                                            e),
                                                                    onSelected:
                                                                        (bool
                                                                            selected) {
                                                                      setState(
                                                                          () {
                                                                        if (selectedlist
                                                                            .contains(e)) {
                                                                          selectedlist
                                                                              .remove(e);
                                                                        } else {
                                                                          selectedlist
                                                                              .add(e);
                                                                        }
                                                                      });
                                                                    },
                                                                  ),
                                                                )
                                                                .toList(),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 80,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Positioned(
                                                    right: 5,
                                                    left: 5,
                                                    bottom: 5,
                                                    child: GestureDetector(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              const LinearGradient(
                                                            colors: [
                                                              Color(0xFF8942BC),
                                                              Color(0xFF5831F7),
                                                              Color(0xFF5731F8),
                                                              Color(0xFF00C2C2),
                                                            ],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        height: 50,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: Center(
                                                            child: Text(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                FilterPageTranslation
                                                                    .apply)),
                                                      ),
                                                      onTap: () async {
                                                        await filter();
                                                        filterValue = true;
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          )
                          // : Row(
                          //     children: [
                          //       TextButton(
                          //           onPressed: () {
                          //             Navigator.of(context).push(
                          //               MaterialPageRoute(builder: (context) {
                          //                 return WhereTo(
                          //                     boatList:
                          //                         boatListHolder.boatList);
                          //               }),
                          //             );
                          //           },
                          //           child: Text('Search')),
                          //       Spacer(),
                          //       TextButton(
                          //         onPressed: () {
                          //           setState(() {
                          //             //    widget.newBoatList = null;
                          //             // widget.newBoatList = [];
                          //             // widget.filterList = null;
                          //             filterList = [];
                          //             filterValue = false;
                          //             filterList = null;
                          //           });
                          //         },
                          //         child: Text('Rreset'),
                          //       ),
                          //     ],
                          //   ),
                          ),
                      // ((widget.searchFilterList == null ||
                      //             widget.searchFilterList!.isEmpty == true) &&
                      //         widget.searchValue == true)
                      //     ? Text('No result found')
                      //     : ((widget.searchFilterList == null ||
                      //                 widget.searchFilterList!.isEmpty ==
                      //                     true) &&
                      //             (widget.searchValue == false))
                      //         ?
                      ((filterList == null || filterList!.isEmpty == true) &&
                              filterValue == true)
                          ? Text('No result found')
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: (filterList == null ||
                                      filterList!.isEmpty == true)
                                  ? boatListHolder.boatList!.length
                                  : filterList!.length,

                              // here it was boatList!.length
                              itemBuilder: (_, index) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ((filterList == null ||
                                                    filterList!.isEmpty ==
                                                        true) &&
                                                filterValue == false)
                                            ? ShowInformation(
                                                boatinfo: boatListHolder
                                                    .boatList![index],
                                                userTimeNow1:
                                                    widget.userTimeNow1,
                                                userTimeNow2:
                                                    widget.userTimeNow2,
                                              )
                                            : ShowInformation(
                                                boatinfo: filterList![index],
                                                userTimeNow1:
                                                    widget.userTimeNow1,
                                                userTimeNow2:
                                                    widget.userTimeNow2,
                                              );

                                        /* return ShowInformation(
                                    boatList: widget.newBoatList![
                                        index]); */ // here it was boatList![index]
                                      },
                                    ),
                                  );
                                },
                                child:
                                    // CardItemView(
                                    //     items: (widget.newBoatList == null ||
                                    //             widget.newBoatList!.isEmpty)
                                    //         ? boatListHolder.boatList![index].imageList
                                    //         : widget.newBoatList![index].imageList),

                                    CardItemView(
                                        items: ((filterList == null ||
                                                    filterList!.isEmpty ==
                                                        true) &&
                                                filterValue == false)
                                            ? boatListHolder
                                                .boatList![index].imageList
                                            : filterList![index].imageList),
                              ),
                            )
                      // : ListView.builder(
                      //     shrinkWrap: true,
                      //     physics: NeverScrollableScrollPhysics(),
                      //     itemCount: widget.searchFilterList!.length,

                      //     // here it was boatList!.length
                      //     itemBuilder: (_, index) => GestureDetector(
                      //       onTap: () {
                      //         Navigator.of(context).push(
                      //           MaterialPageRoute(
                      //             builder: (context) {
                      //               return ShowInformation(
                      //                 boatinfo: widget
                      //                     .searchFilterList![index],
                      //                 userTimeNow1: widget.userTimeNow1,
                      //                 userTimeNow2: widget.userTimeNow2,
                      //               );

                      //               /* return ShowInformation(
                      //       boatList: widget.newBoatList![
                      //           index]); */ // here it was boatList![index]
                      //             },
                      //           ),
                      //         );
                      //       },
                      //       child:
                      //           // CardItemView(
                      //           //     items: (widget.newBoatList == null ||
                      //           //             widget.newBoatList!.isEmpty)
                      //           //         ? boatListHolder.boatList![index].imageList
                      //           //         : widget.newBoatList![index].imageList),

                      //           CardItemView(
                      //               items: widget
                      //                   .searchFilterList![index]
                      //                   .imageList),
                      //     ),
                      //   ),
                    ],
                  ),
                );
              }
            }));
  }
}

class CardItemView extends StatelessWidget {
  const CardItemView({super.key, required this.items});
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //imagePArt here
          Container(
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: const GradientBoxBorder(
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
            ),
            width: MediaQuery.of(context).size.width * 0.97,
            //height: MediaQuery.of(context).size.height / 2.5,
            child: ImageSliderView(
              imagesPath: items,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class ImageSliderView extends StatefulWidget {
  const ImageSliderView({
    super.key,
    this.imageHeight = 200.0,
    required this.imagesPath,
  });
  //get imageURLs
  final double imageHeight; // or use aspect ratio
  final List<String> imagesPath;

  @override
  State<ImageSliderView> createState() => _ImageSliderViewState();
}

class _ImageSliderViewState extends State<ImageSliderView> {
  int _current = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _current = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final counterView = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < widget.imagesPath.length; i++)
          Container(
            width: 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == i ? Colors.blue : Colors.grey,
            ),
          ),
      ],
    );
    return SizedBox(
      height: widget.imageHeight,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
                itemCount: widget.imagesPath.length,
                controller: _pageController,
                itemBuilder: (context, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        widget.imagesPath[index],
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    )
                // CachedNetworkImage(imageUrl: widget.imagesPath.toString()),
                ),
          ),
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: counterView,
          ),
        ],
      ),
    );
  }
}
