import 'package:design/whereToDesign/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/bout_provider.dart';
import '../translation/filter_translation.dart';

class FilterPage extends ConsumerStatefulWidget {
  FilterPage({super.key});

  @override
  ConsumerState<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends ConsumerState<FilterPage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final boatListHolder = ref.watch(boutProvider);
    //  final boatList = boatListHolder.boatList;
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                boatListHolder.rest();
              });
            },
            child: Text('Rreset'),
          ),
        ],
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
                          '${FilterPageTranslation.from} ${boatListHolder.startPrice.toStringAsFixed(2)} ₽'),
                      Spacer(),
                      Text(
                          '${FilterPageTranslation.to} ${boatListHolder.endPrice.toStringAsFixed(2)} ₽'),
                    ],
                  ),
                  RangeSlider(
                      min: 1,
                      max: 10000,
                      values: RangeValues(
                          boatListHolder.startPrice, boatListHolder.endPrice),
                      onChanged: (RangeValues values) {
                        setState(() {
                          boatListHolder.startPrice = values.start;
                          boatListHolder.endPrice = values.end;
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
                          '${FilterPageTranslation.from} ${boatListHolder.startLength.toStringAsFixed(2)} M'),
                      Spacer(),
                      Text(
                          '${FilterPageTranslation.to} ${boatListHolder.endLength.toStringAsFixed(2)} M')
                    ],
                  ),
                  RangeSlider(
                      min: 1,
                      max: 10000,
                      values: RangeValues(
                          boatListHolder.startLength, boatListHolder.endLength),
                      onChanged: (value) {
                        setState(() {
                          boatListHolder.startLength = value.start;
                          boatListHolder.endLength = value.end;
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
                          '${FilterPageTranslation.from} ${boatListHolder.startRating.toStringAsFixed(1)} '),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Spacer(),
                      Text(
                          '${FilterPageTranslation.to} ${boatListHolder.endRating.toStringAsFixed(1)} '),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                    ],
                  ),
                  RangeSlider(
                      min: 1,
                      max: 5,
                      values: RangeValues(
                          boatListHolder.startRating, boatListHolder.endRating),
                      onChanged: (value) {
                        setState(() {
                          boatListHolder.startRating = value.start;
                          boatListHolder.endRating = value.end;
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
                          selected: boatListHolder.shipType == index,
                          onSelected: (bool selected) {
                            setState(() {
                              boatListHolder.shipType = selected ? index : null;
                              if (boatListHolder.shipType == 0) {
                                boatListHolder.theShipTypeValue = 'Motor';
                              } else if (boatListHolder.shipType == 1) {
                                boatListHolder.theShipTypeValue = 'Sailing';
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
                          selected: boatListHolder.toilet == index,
                          onSelected: (bool selected) {
                            setState(() {
                              boatListHolder.toilet = selected ? index : null;
                              if (boatListHolder.toilet == 0) {
                                boatListHolder.theToiletValue = 'Not important';
                              } else if (boatListHolder.toilet == 1) {
                                boatListHolder.theToiletValue = 'Yes';
                              } else if (boatListHolder.toilet == 2) {
                                boatListHolder.theToiletValue = 'No';
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
                              value: boatListHolder.rainValue ?? false,
                              onChanged: (value) {
                                setState(() {
                                  boatListHolder.rainValue = value;
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
                              value: boatListHolder.bimini ?? false,
                              onChanged: (value) {
                                setState(() {
                                  boatListHolder.bimini = value;
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
                              value: boatListHolder.bluetooth ?? false,
                              onChanged: (value) {
                                setState(() {
                                  boatListHolder.bluetooth = value;
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
                              value: boatListHolder.mask ?? false,
                              onChanged: (value) {
                                setState(() {
                                  boatListHolder.mask = value;
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
                              value: boatListHolder.shower ?? false,
                              onChanged: (value) {
                                setState(() {
                                  boatListHolder.shower = value;
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
                              value: boatListHolder.fridge ?? false,
                              onChanged: (value) {
                                setState(() {
                                  boatListHolder.fridge = value;
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
                              value: boatListHolder.blankets ?? false,
                              onChanged: (value) {
                                setState(() {
                                  boatListHolder.blankets = value;
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
                              value: boatListHolder.table ?? false,
                              onChanged: (value) {
                                setState(() {
                                  boatListHolder.table = value;
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
                              value: boatListHolder.glasses ?? false,
                              onChanged: (value) {
                                setState(() {
                                  boatListHolder.glasses = value;
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
                              value: boatListHolder.bathing ?? false,
                              onChanged: (value) {
                                setState(() {
                                  boatListHolder.bathing = value;
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
                              value: boatListHolder.fishEcho ?? false,
                              onChanged: (value) {
                                setState(() {
                                  boatListHolder.fishEcho = value;
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
                              value: boatListHolder.heater ?? false,
                              onChanged: (value) {
                                setState(() {
                                  boatListHolder.heater = value;
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
                              value: boatListHolder.climate ?? false,
                              onChanged: (value) {
                                setState(() {
                                  boatListHolder.climate = value;
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
                      children: boatListHolder.list
                          .map(
                            (e) => ChoiceChip(
                              selectedColor: Color(0xFF5731F8),
                              disabledColor: Color(0xFF8942BC),
                              label: Text(e),
                              selected: boatListHolder.selectedlist.contains(e),
                              onSelected: (bool selected) {
                                setState(() {
                                  if (boatListHolder.selectedlist.contains(e)) {
                                    boatListHolder.selectedlist.remove(e);
                                  } else {
                                    boatListHolder.selectedlist.add(e);
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
                onTap: () async {
                  await boatListHolder.filter();

                  boatListHolder.filterValue = true;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return HomePage();
                      },
                    ),
                  );
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
