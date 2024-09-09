import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../translation/filter_translation.dart';

class FilterPage extends ConsumerStatefulWidget {
  const FilterPage({super.key});

  @override
  ConsumerState<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends ConsumerState<FilterPage> {
  double startPrice = 1;
  double endPrice = 100000;
  double startLength = 1;
  double endLength = 100000;
  double startRating = 1;
  double endRating = 5;
  int? shipType;
  int? toilet;
  bool rainValue = false;
  bool bimini = false;
  bool bluetooth = false;
  bool mask = false;
  bool shower = false;
  bool fridge = false;
  bool blanckets = false;
  bool table = false;
  bool glasses = false;
  bool bathing = false;
  bool fishEcho = false;
  bool heater = false;
  bool climate = false;
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
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(FilterPageTranslation.filter),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close_rounded),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    FilterPageTranslation.price,
                    style: TextStyle(fontSize: 20),
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
                      max: 100000,
                      values: RangeValues(startPrice, endPrice),
                      onChanged: (RangeValues values) {
                        setState(() {
                          startPrice = values.start;
                          endPrice = values.end;
                        });
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    FilterPageTranslation.length,
                    style: TextStyle(fontSize: 20),
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
                      max: 100000,
                      values: RangeValues(startLength, endLength),
                      onChanged: (value) {
                        setState(() {
                          startLength = value.start;
                          endLength = value.end;
                        });
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    FilterPageTranslation.rating,
                    style: TextStyle(fontSize: 20),
                  ),
                  Row(
                    children: [
                      Text(
                          '${FilterPageTranslation.from} ${startRating.toStringAsFixed(1)} '),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Spacer(),
                      Text(
                          '${FilterPageTranslation.to} ${endRating.toStringAsFixed(1)} '),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                    ],
                  ),
                  RangeSlider(
                      min: 1,
                      max: 5,
                      values: RangeValues(startRating, endRating),
                      onChanged: (value) {
                        setState(() {
                          startRating = value.start;
                          endRating = value.end;
                        });
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    FilterPageTranslation.type,
                    style: TextStyle(fontSize: 20),
                  ),
                  Wrap(
                    spacing: 15.0,
                    children: List<Widget>.generate(
                      2,
                      (int index) {
                        return ChoiceChip(
                          selectedColor: Color(0xFF5731F8),
                          disabledColor: Color(0xFF8942BC),
                          label: Text(
                              ' ${index == 0 ? FilterPageTranslation.motor : FilterPageTranslation.sailing}'),
                          selected: shipType == index,
                          onSelected: (bool selected) {
                            setState(() {
                              shipType = selected ? index : null;
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
                    FilterPageTranslation.toilet,
                    style: TextStyle(fontSize: 20),
                  ),
                  Wrap(
                    spacing: 10.0,
                    children: List<Widget>.generate(
                      3,
                      (int index) {
                        return ChoiceChip(
                          selectedColor: Color(0xFF5731F8),
                          disabledColor: Color(0xFF8942BC),
                          label: Text(
                              ' ${index == 0 ? FilterPageTranslation.notImportant : index == 1 ? FilterPageTranslation.yes : FilterPageTranslation.no}'),
                          selected: toilet == index,
                          onSelected: (bool selected) {
                            setState(() {
                              toilet = selected ? index : null;
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
                    FilterPageTranslation.amenities,
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(FilterPageTranslation.rain),
                            Spacer(),
                            CupertinoSwitch(
                              value: rainValue,
                              onChanged: (value) {
                                setState(() {
                                  rainValue = value;
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(FilterPageTranslation.biminiSunshade),
                            Spacer(),
                            CupertinoSwitch(
                              value: bimini,
                              onChanged: (value) {
                                setState(() {
                                  bimini = value;
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(FilterPageTranslation.bluetooth),
                            Spacer(),
                            CupertinoSwitch(
                              value: bluetooth,
                              onChanged: (value) {
                                setState(() {
                                  bluetooth = value;
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(FilterPageTranslation.snorkeling),
                            Spacer(),
                            CupertinoSwitch(
                              value: mask,
                              onChanged: (value) {
                                setState(() {
                                  mask = value;
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(FilterPageTranslation.shower),
                            Spacer(),
                            CupertinoSwitch(
                              value: shower,
                              onChanged: (value) {
                                setState(() {
                                  shower = value;
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(FilterPageTranslation.fridge),
                            Spacer(),
                            CupertinoSwitch(
                              value: fridge,
                              onChanged: (value) {
                                setState(() {
                                  fridge = value;
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(FilterPageTranslation.blankets),
                            Spacer(),
                            CupertinoSwitch(
                              value: blanckets,
                              onChanged: (value) {
                                setState(() {
                                  blanckets = value;
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(FilterPageTranslation.table),
                            Spacer(),
                            CupertinoSwitch(
                              value: table,
                              onChanged: (value) {
                                setState(() {
                                  table = value;
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(FilterPageTranslation.glasses),
                            Spacer(),
                            CupertinoSwitch(
                              value: glasses,
                              onChanged: (value) {
                                setState(() {
                                  glasses = value;
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text('Bathing platform'),
                            Spacer(),
                            CupertinoSwitch(
                              value: bathing,
                              onChanged: (value) {
                                setState(() {
                                  bathing = value;
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(FilterPageTranslation.fishEcho),
                            Spacer(),
                            CupertinoSwitch(
                              value: fishEcho,
                              onChanged: (value) {
                                setState(() {
                                  fishEcho = value;
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(FilterPageTranslation.heater),
                            Spacer(),
                            CupertinoSwitch(
                              value: heater,
                              onChanged: (value) {
                                setState(() {
                                  heater = value;
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(FilterPageTranslation.climate),
                            Spacer(),
                            CupertinoSwitch(
                              value: climate,
                              onChanged: (value) {
                                setState(() {
                                  climate = value;
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
                    FilterPageTranslation.features,
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Wrap(
                      spacing: 15.0,
                      children: list
                          .map(
                            (e) => ChoiceChip(
                              selectedColor: Color(0xFF5731F8),
                              disabledColor: Color(0xFF8942BC),
                              label: Text(e),
                              selected: selectedlist.contains(e),
                              onSelected: (bool selected) {
                                setState(() {
                                  if (selectedlist.contains(e)) {
                                    selectedlist.remove(e);
                                  } else {
                                    selectedlist.add(e);
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
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: Text(
                          textAlign: TextAlign.center,
                          FilterPageTranslation.apply)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
