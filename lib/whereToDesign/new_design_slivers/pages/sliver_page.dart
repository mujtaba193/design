import 'package:design/whereToDesign/providers/city_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/gradient_borders.dart';

import '../../change_notifier/boat_provider_change_notifire.dart';
import '../../change_notifier/search_filter_change_notifier.dart';
import '../../providers/filter/search_filter_provider.dart';
import '../../providers/second_list_image_provider.dart';

class SliverBar extends ConsumerStatefulWidget {
  const SliverBar({super.key});

  @override
  ConsumerState<SliverBar> createState() => _SliverBarState();
}

class _SliverBarState extends ConsumerState<SliverBar> {
  String? slectedevent;
  String? slectedCity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cityNameImage = ref.read(cityProvider);
    final boatListHolder = ref.watch(boatProviderChangeNotifier);
    final secondListImage = ref.read(secondListImageProvider);
    final searchFilterState = ref.read(searchFilterProvider);
    final cityHolder = ref.read(cityProvider);
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            stretch: true,
            onStretchTrigger: () async {
              // Triggers when stretching
            },
            stretchTriggerOffset: 300.0,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return SearchFilterChangeNotifier();
                        // return SearchFilter();
                      }),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade600,
                      borderRadius: BorderRadius.circular(8),
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
                    ),
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Icon(Icons.search_rounded),
                        Text(
                          'Direction, date, time, goste',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              background: Image.network(
                'https://www.23mayfield.co.uk/images/internals/edinburgh.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // here we are showing Cities in this section. SliverToBoxAdapter
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: FutureBuilder(
                future: cityNameImage.readJsondata(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    return Container(
                        child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...cityNameImage.cityList!.cities.map(
                            (e) => Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () async {
                                      // here we set a value to the variable "selectedCityName".
                                      cityHolder.selectedCityName = e.cityName;
                                      // here we set a value to the variable "cityEvents".
                                      cityHolder.getEvents();

                                      await boatListHolder.moveToSelectedCity(
                                          ref
                                              .read(cityProvider)
                                              .selectedCityName
                                              .toString());
                                      boatListHolder.value = true;
                                      // Navigator.of(context).push(
                                      //   MaterialPageRoute(builder: (context) {
                                      //     return HomePage();
                                      //   }),
                                      // );
                                      // boatListHolder.filterList;
                                    },
                                    child: Container(
                                      decoration: ref
                                                  .read(cityProvider)
                                                  .selectedCityName ==
                                              e.cityName
                                          ? BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.green),
                                            )
                                          : null,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          height: 100,
                                          width: 100,
                                          e.cityImage,
                                          fit: BoxFit.fill,
                                          alignment: Alignment.topCenter,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      e.cityName),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ));
                  }
                }),
          )),
//........................................................................................................................................
          // here we are showing events in this section. SliverToBoxAdapter
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: FutureBuilder(
                  future: secondListImage.readJsondata(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      return Container(
                          child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...secondListImage.secondList.map(
                              (e) => Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          searchFilterState.timeValue2 =
                                              e.minHours;
                                          cityHolder.selectedCityName =
                                              e.cityName;
                                          cityHolder.getEvents();
                                          // cityHolder.cityEvents!.where(
                                          //     (element) =>
                                          //         element.eventName ==
                                          //         e.eventName);
                                          cityHolder.selectedevent =
                                              e.eventName;
                                          boatListHolder.value = true;

                                          cityHolder
                                              .getSelectedEventMinHoursFirstPage(
                                                  e.minHours);
                                        });
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                            return SearchFilterChangeNotifier();
                                          }),
                                        );
                                      },
                                      child: Container(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.network(
                                            height: 100,
                                            width: 200,
                                            e.eventImage.first,
                                            fit: BoxFit.fill,
                                            alignment: Alignment.topCenter,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text('${e.eventName}'),
                                    Text(
                                      "${e.date.day < 10 ? '0${e.date.day}' : e.date.day}-${e.date.month < 10 ? '0${e.date.month}' : e.date.month}-${e.date.year} ",
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.location_city),
                                        SizedBox(width: 5),
                                        Text(
                                            overflow: TextOverflow.ellipsis,
                                            e.cityName),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ));
                    }
                  }),
            ),
          ),
          /////////////////////////////////////////..................................////////////////////////////////////////////
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: FutureBuilder(
                  future: secondListImage.readJsondata(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      return Column(
                        children: [
                          Container(
                            height: 600,
                            color: Colors.grey.shade900,
                          ),
                          Container(
                            height: 600,
                            color: Colors.grey.shade900,
                          ),
                        ],
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
