import 'package:design/whereToDesign/providers/city_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../appconfig.dart';
import '../translation/filter_translation.dart';
import 'boat_provider_change_notifire.dart';

class FilterPageChangeNotifier extends ConsumerStatefulWidget {
  FilterPageChangeNotifier({super.key});

  @override
  ConsumerState<FilterPageChangeNotifier> createState() => _FilterPageState();
}

class _FilterPageState extends ConsumerState<FilterPageChangeNotifier> {
  Color color = AppConfig.fontColor;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final boatListHolder = ref.read(boatProviderChangeNotifier);
    //  final boatList = boatListHolder.boatList;
    return Scaffold(
      backgroundColor: Colors.blue,
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
        //centerTitle: true,
        // Filter
        title: Text(
          FilterPageTranslation.filter,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppConfig.fontColor),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset('assets/Vectorback.svg'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppConfig.cardColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            FilterPageTranslation.price,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: AppConfig.fontColor2),
                          ),
                          Row(
                            children: [
                              Text(
                                '${FilterPageTranslation.from} ${boatListHolder.startPrice.toStringAsFixed(2)} ₽',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: AppConfig.fontColor),
                              ),
                              Spacer(),
                              Text(
                                '${FilterPageTranslation.to} ${boatListHolder.endPrice.toStringAsFixed(2)} ₽',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: AppConfig.fontColor),
                              ),
                            ],
                          ),
                          RangeSlider(
                            activeColor: AppConfig.iconColor,
                            inactiveColor:
                                AppConfig.fontColor.withOpacity(0.25),
                            min: 1,
                            max: 10000,
                            values: RangeValues(boatListHolder.startPrice,
                                boatListHolder.endPrice),
                            onChanged: (RangeValues values) {
                              setState(() {
                                boatListHolder.startPrice = values.start;
                                boatListHolder.endPrice = values.end;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            FilterPageTranslation.length,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: AppConfig.fontColor2),
                          ),
                          Row(
                            children: [
                              Text(
                                '${FilterPageTranslation.from} ${boatListHolder.startLength.toStringAsFixed(2)} M',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: AppConfig.fontColor),
                              ),
                              Spacer(),
                              Text(
                                '${FilterPageTranslation.to} ${boatListHolder.endLength.toStringAsFixed(2)} M',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: AppConfig.fontColor),
                              )
                            ],
                          ),
                          // the length.
                          RangeSlider(
                            activeColor: AppConfig.iconColor,
                            inactiveColor:
                                AppConfig.fontColor.withOpacity(0.25),
                            min: 1,
                            max: 10000,
                            values: RangeValues(boatListHolder.startLength,
                                boatListHolder.endLength),
                            onChanged: (value) {
                              setState(() {
                                boatListHolder.startLength = value.start;
                                boatListHolder.endLength = value.end;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // the rating
                          Text(
                            FilterPageTranslation.rating,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: AppConfig.fontColor2),
                          ),
                          Row(
                            children: [
                              Text(
                                '${FilterPageTranslation.from} ${boatListHolder.startRating.toStringAsFixed(1)} ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: AppConfig.fontColor),
                              ),
                              Icon(
                                Icons.star,
                                color: AppConfig.starColor,
                              ),
                              Spacer(),
                              Text(
                                '${FilterPageTranslation.to} ${boatListHolder.endRating.toStringAsFixed(1)} ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: AppConfig.fontColor),
                              ),
                              Icon(
                                Icons.star,
                                color: AppConfig.starColor,
                              ),
                            ],
                          ),
                          RangeSlider(
                              activeColor: AppConfig.iconColor,
                              inactiveColor:
                                  AppConfig.fontColor.withOpacity(0.25),
                              min: 1,
                              max: 5,
                              values: RangeValues(boatListHolder.startRating,
                                  boatListHolder.endRating),
                              onChanged: (value) {
                                setState(() {
                                  boatListHolder.startRating = value.start;
                                  boatListHolder.endRating = value.end;
                                });
                              }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: AppConfig.cardColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            FilterPageTranslation.type,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: AppConfig.fontColor2),
                          ),
                          Wrap(
                            spacing: 15.0,
                            children: List<Widget>.generate(
                              2,
                              (int index) {
                                final isSelected =
                                    boatListHolder.shipType == index;
                                return ChoiceChip(
                                  selectedColor: AppConfig.iconColor,
                                  disabledColor:
                                      AppConfig.fontColor.withOpacity(0.25),
                                  label: Text(
                                    ' ${index == 0 ? FilterPageTranslation.motor : FilterPageTranslation.sailing}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: isSelected
                                            ? AppConfig.cardColor
                                            : AppConfig.fontColor),
                                  ),
                                  selected: isSelected,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      boatListHolder.shipType =
                                          selected ? index : null;
                                      if (boatListHolder.shipType == 0) {
                                        boatListHolder.theShipTypeValue =
                                            'Motor';
                                      } else if (boatListHolder.shipType == 1) {
                                        boatListHolder.theShipTypeValue =
                                            'Sailing';
                                      }
                                    });
                                  },
                                );
                              },
                            ).toList(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: AppConfig.cardColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            FilterPageTranslation.toilet,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: AppConfig.fontColor2),
                          ),
                          Wrap(
                            spacing: 10.0,
                            children: List<Widget>.generate(
                              3,
                              (int index) {
                                final isSelected =
                                    boatListHolder.toilet == index;
                                return ChoiceChip(
                                  selectedColor: AppConfig.iconColor,
                                  disabledColor:
                                      AppConfig.fontColor.withOpacity(0.25),
                                  label: Text(
                                    ' ${index == 0 ? FilterPageTranslation.notImportant : index == 1 ? FilterPageTranslation.yes : FilterPageTranslation.no}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: isSelected
                                            ? AppConfig.cardColor
                                            : AppConfig.fontColor),
                                  ),
                                  selected: isSelected,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      boatListHolder.toilet =
                                          selected ? index : null;
                                      if (boatListHolder.toilet == 0) {
                                        boatListHolder.theToiletValue =
                                            'Not important';
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: AppConfig.cardColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            FilterPageTranslation.amenities,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: AppConfig.fontColor2),
                          ),
                          Row(
                            children: [
                              Text(
                                FilterPageTranslation.rain,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppConfig.fontColor),
                              ),
                              Spacer(),
                              CupertinoSwitch(
                                activeColor: AppConfig.iconColor,
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
                              Text(
                                FilterPageTranslation.biminiSunshade,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppConfig.fontColor),
                              ),
                              Spacer(),
                              CupertinoSwitch(
                                activeColor: AppConfig.iconColor,
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
                              Text(
                                FilterPageTranslation.bluetooth,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppConfig.fontColor),
                              ),
                              Spacer(),
                              CupertinoSwitch(
                                activeColor: AppConfig.iconColor,
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
                              Text(
                                FilterPageTranslation.snorkeling,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppConfig.fontColor),
                              ),
                              Spacer(),
                              CupertinoSwitch(
                                activeColor: AppConfig.iconColor,
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
                              Text(
                                FilterPageTranslation.shower,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppConfig.fontColor),
                              ),
                              Spacer(),
                              CupertinoSwitch(
                                activeColor: AppConfig.iconColor,
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
                              Text(
                                FilterPageTranslation.fridge,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppConfig.fontColor),
                              ),
                              Spacer(),
                              CupertinoSwitch(
                                activeColor: AppConfig.iconColor,
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
                              Text(
                                FilterPageTranslation.blankets,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppConfig.fontColor),
                              ),
                              Spacer(),
                              CupertinoSwitch(
                                activeColor: AppConfig.iconColor,
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
                              Text(
                                FilterPageTranslation.table,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppConfig.fontColor),
                              ),
                              Spacer(),
                              CupertinoSwitch(
                                activeColor: AppConfig.iconColor,
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
                              Text(
                                FilterPageTranslation.glasses,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppConfig.fontColor),
                              ),
                              Spacer(),
                              CupertinoSwitch(
                                activeColor: AppConfig.iconColor,
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
                              Text(
                                'Bathing platform',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppConfig.fontColor),
                              ),
                              Spacer(),
                              CupertinoSwitch(
                                activeColor: AppConfig.iconColor,
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
                              Text(
                                FilterPageTranslation.fishEcho,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppConfig.fontColor),
                              ),
                              Spacer(),
                              CupertinoSwitch(
                                activeColor: AppConfig.iconColor,
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
                              Text(
                                FilterPageTranslation.heater,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppConfig.fontColor),
                              ),
                              Spacer(),
                              CupertinoSwitch(
                                activeColor: AppConfig.iconColor,
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
                              Text(
                                FilterPageTranslation.climate,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppConfig.fontColor),
                              ),
                              Spacer(),
                              CupertinoSwitch(
                                activeColor: AppConfig.iconColor,
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
                      height: 16,
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: AppConfig.cardColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            FilterPageTranslation.features,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: AppConfig.fontColor2),
                          ),
                          Wrap(
                            spacing: 15.0,
                            children: boatListHolder.list.map((e) {
                              final isSelected =
                                  boatListHolder.selectedlist.contains(e);
                              return ChoiceChip(
                                selectedColor: AppConfig.iconColor,
                                disabledColor:
                                    AppConfig.fontColor.withOpacity(0.25),
                                label: Text(
                                  e,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: isSelected
                                          ? AppConfig.cardColor
                                          : AppConfig.fontColor),
                                ),
                                selected: isSelected,
                                onSelected: (bool selected) {
                                  setState(() {
                                    if (boatListHolder.selectedlist
                                        .contains(e)) {
                                      boatListHolder.selectedlist.remove(e);
                                    } else {
                                      boatListHolder.selectedlist.add(e);
                                    }
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
              Positioned(
                right: 4,
                left: 4,
                bottom: 5,
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppConfig.iconColor2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        FilterPageTranslation.apply,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppConfig.cardColor),
                      ),
                    ),
                  ),
                  onTap: () async {
                    await boatListHolder
                        .filter(ref.read(cityProvider).selectedCityName);

                    // boatListHolder.filterValue = true;
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return HomePage();
                    //     },
                    //   ),
                    // );
                    setState(() {});
                    Navigator.pop(context);
                    // Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
