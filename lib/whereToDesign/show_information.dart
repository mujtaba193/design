import 'dart:convert';

import 'package:design/heatSrc/src/data/heatmap_color_mode.dart';
import 'package:design/heatSrc/src/heatmap_calendar.dart';
import 'package:design/whereToDesign/Calendar%20classes/table_events.dart';
import 'package:design/whereToDesign/full_map.dart';
import 'package:design/whereToDesign/list_image_view.dart';
import 'package:design/whereToDesign/review2.dart';
import 'package:design/whereToDesign/users_model/boat_model.dart';
import 'package:design/whereToDesign/where_to.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart' as yandexgeo;
import 'package:yandex_mapkit/yandex_mapkit.dart';

// API Yandex key   c29e3f51-6ad9-47eb-85d2-d90aec454225
class ShowInformation extends StatefulWidget {
  final BoatModel? boatinfo;
  DateTime? userTimeNow1;
  DateTime? userTimeNow2;
  bool? isBooked;
  ShowInformation(
      {super.key,
      this.boatinfo,
      this.userTimeNow2,
      this.userTimeNow1,
      this.isBooked});

  @override
  State<ShowInformation> createState() => _ShowInformationState();
}

class _ShowInformationState extends State<ShowInformation> {
  late int minimum;
  late int meduim;
  late int largest;
  late List<int> allNumbers = [];
  final yandexgeo.YandexGeocoder geocoder = yandexgeo.YandexGeocoder(
      apiKey: 'AIzaSyD_EXNQjjvmLVJE37nA8zVQdTPRDcQStYE');

  String address = 'null';
  String latLong = 'null';

  @override
  void initState() {
    sortingList();

    super.initState();
  }

  sortingList() {
    for (var val in widget.boatinfo!.datasets.values) {
      allNumbers!.add(val);
    }
    allNumbers!.sort();
    minimum = allNumbers!.first;
    largest = allNumbers!.last;
    meduim = ((minimum! + largest!) / 2).floor();
  }

  void shareInfo() {
    CardItemView hh = CardItemView(
      items: widget.boatinfo!.imageList,
    );
    AndroidYandexMap.useAndroidViewSurface = false;
    String massage = 'share the information';
    Share.share(massage);
    // Share.shareUri(widget.boatList.imageList.toString());
    Share;
  }

/*  Future<void> openMap(longitude, latitude) async {
    Uri url = Uri.parse(
      "yandexmaps://maps.yandex.ru/?pt=$longitude,$latitude&z=20&l=map&",
    );
    if (await launchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'could not open';
    }
  }*/

  Future<void> openMap(longitude, latitude) async {
    String apiKey = 'AIzaSyD_EXNQjjvmLVJE37nA8zVQdTPRDcQStYE';
    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      String address = data['results'][0]['formatted_address'];
      Uri yandexMapsUrl =
          Uri.parse("yandexmaps://maps.yandex.ru/?text=$address&z=20&l=map");
      if (await launchUrl(yandexMapsUrl)) {
        await launchUrl(yandexMapsUrl);
      } else {
        throw 'Could not open Yandex Maps';
      }
    } else {
      throw 'Failed to load address data';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width / 2,
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
        child: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return WhereTo(isSearch: false, boatinfo: widget.boatinfo);
                },
              ),
            );
          },
          child: Text(
            '${(widget.isBooked == false || widget.userTimeNow1 != null) ? 'booked at ${widget.userTimeNow1!.day}-${widget.userTimeNow1!.month}-${widget.userTimeNow1!.year}  ${widget.userTimeNow1!.hour < 10 ? '0${widget.userTimeNow1!.hour}' : widget.userTimeNow1!.hour}:${widget.userTimeNow1!.minute < 10 ? '0${widget.userTimeNow1!.minute}' : widget.userTimeNow1!.minute} to ${widget.userTimeNow2!.hour < 10 ? '0${widget.userTimeNow2!.hour}' : widget.userTimeNow2!.hour}:${widget.userTimeNow2!.minute < 10 ? '0${widget.userTimeNow2!.minute}' : widget.userTimeNow2!.minute}' : 'chose time'}',
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite),
          ),
          IconButton(
            onPressed: () {
              shareInfo();
            },
            icon: Icon(Icons.share_sharp),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ImageListView(
                      imageListed: widget.boatinfo!.imageList,
                    );
                  }));
                },
                child: CardItemView(
                  items: widget.boatinfo!.imageList,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(
                MediaQuery.of(context).size.width * 0.01,
              ),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
              decoration: const BoxDecoration(
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
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        'Owner',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      Text(
                        '${widget.boatinfo!.boatName}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Icon(Icons.price_change),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        'Price',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      Text(
                        '${widget.boatinfo!.finalPrice} ₽',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Icon(Icons.people_alt),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        'Guests',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      Text(
                        '${widget.boatinfo!.guests}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_city),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        'City',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      Text(
                        '${widget.boatinfo!.city}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Icon(Icons.sell),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        'Already booked',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      Text(
                        '${widget.boatinfo!.bookedStartTime.year}-${widget.boatinfo!.bookedStartTime.month < 10 ? '0${widget.boatinfo!.bookedStartTime.month}' : widget.boatinfo!.bookedStartTime.month}-${widget.boatinfo!.bookedStartTime.day < 10 ? '0${widget.boatinfo!.bookedStartTime.day}' : widget.boatinfo!.bookedStartTime.day} ( ${widget.boatinfo!.bookedStartTime.hour < 10 ? '0${widget.boatinfo!.bookedStartTime.hour}' : widget.boatinfo!.bookedStartTime.hour}:${widget.boatinfo!.bookedStartTime.minute < 10 ? '0${widget.boatinfo!.bookedStartTime.minute}' : widget.boatinfo!.bookedStartTime.minute} to ${widget.boatinfo!.bookedFinishTime.hour < 10 ? '0${widget.boatinfo!.bookedFinishTime.hour}' : widget.boatinfo!.bookedFinishTime.hour}:${widget.boatinfo!.bookedFinishTime.minute < 10 ? '0${widget.boatinfo!.bookedFinishTime.minute}' : widget.boatinfo!.bookedFinishTime.minute})',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Container(
                    margin: EdgeInsets.all(
                      MediaQuery.of(context).size.width * 0.01,
                    ),
                    //padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                    decoration: const BoxDecoration(
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
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    height: 300,
                    width: 500,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(18.0),
                        child: YandexMap(
                          onMapTap: (a) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return FullMap(
                                      address: widget.boatinfo!.address);
                                },
                              ),
                            );
                          },
                          nightModeEnabled: true,
                          mapObjects: [
                            ...widget.boatinfo!.address
                                .map(
                                  (e) => PlacemarkMapObject(
                                      icon: PlacemarkIcon.single(
                                        PlacemarkIconStyle(
                                          //rotationType: RotationType.rotate,
                                          isFlat: true,
                                          scale: 0.5,
                                          image:
                                              BitmapDescriptor.fromAssetImage(
                                                  'asset/markicon.png'),
                                        ),
                                      ),
                                      mapId: MapObjectId(e.username),
                                      point: Point(
                                          latitude: e.latitude,
                                          longitude: e.longitude),
                                      // text: PlacemarkText(
                                      //   text: '${e.username}',
                                      //   style: PlacemarkTextStyle(),
                                      // ),
                                      opacity: 3),
                                )
                                .toList(),
                          ],
                          onMapCreated: (YandexMapController controller) {
                            controller.moveCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                              target: Point(
                                  latitude:
                                      widget.boatinfo!.address.first.latitude,
                                  longitude:
                                      widget.boatinfo!.address.first.longitude),
                            )));
                          },
                        )),
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.of(context).push(
                  //       MaterialPageRoute(
                  //         builder: (context) {
                  //           return DrivingExample();
                  //         },
                  //       ),
                  //     );

                  //     // openMap(widget.boatinfo!.address.longitude,
                  //     //     widget.boatinfo!.address.latitude); //"st. peter"
                  //   },
                  //   child: Text('Go to app'),
                  // ),
                  Row(
                    children: [
                      Icon(Icons.description),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        'Description',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(),
                    ),
                    child: ReadMoreText(
                      '${widget.boatinfo!.description}',
                      trimLines: 4,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Readmore',
                      trimExpandedText: 'Readless',
                      moreStyle: TextStyle(color: Colors.blue),
                      lessStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons
                              .category), // Icon representing characteristics
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          Text(
                            'Options', // Title for characteristics
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ), // Space between title and characteristics
                      Wrap(
                        spacing: 8, // Horizontal space between chips
                        runSpacing: 8, // Vertical space between chips
                        children: widget.boatinfo!.options.map((options) {
                          return Container(
                            decoration: const BoxDecoration(
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
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(options),
                            ), // Display characteristic as chip
                          );
                        }).toList(),
                      ),
                      //Text(widget.boatList.characteristics.shipyard)
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Icon(Icons.sailing),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        'characteristics',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Text('Shipyard'),
                      Spacer(),
                      Text(widget.boatinfo!.characteristics.shipyard),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Model'),
                      Spacer(),
                      Text(widget.boatinfo!.characteristics.model),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Year'),
                      Spacer(),
                      Text('${widget.boatinfo!.characteristics.year}'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Length'),
                      Spacer(),
                      Text('${widget.boatinfo!.characteristics.length}'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Width'),
                      Spacer(),
                      Text('${widget.boatinfo!.characteristics.width}'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Power'),
                      Spacer(),
                      Text(widget.boatinfo!.characteristics.power),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Walking speed'),
                      Spacer(),
                      Text(widget.boatinfo!.characteristics.walking_speed),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Cabins'),
                      Spacer(),
                      Text('${widget.boatinfo!.characteristics.cabins}'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Sleepingplaces'),
                      Spacer(),
                      Text(
                          '${widget.boatinfo!.characteristics.sleeping_places}'),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  /*InkWell(
                    child: Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                        border: GradientBoxBorder(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF8942BC),
                              Color(0xFF5831F7),
                              Color(0xFF5731F8),
                              Color(0xFF00C2C2),
                            ],
                          ),
                        ),
                        borderRadius: BorderRadius.circular(10),
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
                  ),*/
                  HeatMapCalendar(
                    defaultColor: Colors.grey,
                    textColor: Colors.white,
                    flexible: true,
                    colorMode: ColorMode.color,
                    datasets: widget.boatinfo!.datasets,
                    colorsets: {
                      minimum!: Colors.green.withOpacity(0.7),
                      meduim!: Colors.yellow.withOpacity(0.6),
                      largest!: Colors.red.withOpacity(0.6),
                      //1: Colors.green.withOpacity(0.7),
                      //5: Colors.yellow,
                      //13: Colors.red.withOpacity(0.6),
                      //   3: Colors.orange,
                      //9: Colors.blue,
                      //    11: Colors.indigo,
                      //   13: Colors.purple,
                    },
                    onClick: (value) {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(content: Text(value.toString())));
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return TableEvents(
                            timeLine: widget.boatinfo!.timeline,
                            selectedDate: value);
                      }));
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
