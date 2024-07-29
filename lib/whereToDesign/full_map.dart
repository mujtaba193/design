import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:design/whereToDesign/routes/bicycle_page.dart';
import 'package:design/whereToDesign/routes/driving_page.dart';
import 'package:design/whereToDesign/routes/pedestrian_page.dart';
import 'package:design/whereToDesign/users_model/address_model.dart';
import 'package:design/whereToDesign/yandex_map.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class FullMap extends StatefulWidget {
  List<AddressModel> address;

  FullMap({super.key, required this.address});

  @override
  State<FullMap> createState() => _FullMapState();
}

class _FullMapState extends State<FullMap> {
  late final YandexMapController controller;
  double zoom = 15.0;
  late final GeoObject geoObject;

  late bool servicesEnabled;
  late PermissionStatus permission;
  double? lat;
  double? long;
  double? endLatitude;
  double? endLongitude;
  MapType mapType = MapType.vector;
  late PlacemarkMapObject endPlacemark;
  late PlacemarkMapObject startPlacemark;

  late PlacemarkMapObject currentLocationPlacemark;

  late List<MapObject> drivingMapObjects = [];
  bool _progress = true;
  late Future<DrivingSessionResult> result;
  late DrivingSession session;
  final List<DrivingSessionResult> results = [];
  // polygon definitions //
  bool _drawPolygonEnabled = false;
  List<Point> _userPolyLinesLatLngList = [];

  bool _clearDrawing = false;
  double? _lastXCoordinate, _lastYCoordinate;
  final MapObjectId mapObjectId = const MapObjectId('polyline');
  final List<MapObject> mapObjects = [];
  late List<AddressModel> insidePolygon = [];
  @override
  void initState() {
    getCurrentLucation();
    lat;
    long;
    if (lat != null) {
      drivingMapObjects = [startPlacemark, endPlacemark];
    }
    mapObjectId;
    mapObjects;

    super.initState();
  }
  ////////////////////////// polygon //////////////////////////////////////////////////

  _toggleDrawing() {
    _clearPolygons();
    setState(() => _drawPolygonEnabled = !_drawPolygonEnabled);
  }

  _onPanUpdate(DragUpdateDetails details) async {
    // To start draw new polygon every time.
    if (_clearDrawing) {
      _clearDrawing = false;
      _clearPolygons();
    }

    if (_drawPolygonEnabled) {
      double x, y;

      x = details.globalPosition.dx * 2.75;
      y = details.globalPosition.dy * 2.75;

      // Round the x and y.
      double xCoordinate = x;
      double yCoordinate = y;

      // Cached the coordinate.
      _lastXCoordinate = xCoordinate;
      _lastYCoordinate = yCoordinate;

      ScreenPoint screenPoint =
          ScreenPoint(x: _lastXCoordinate!, y: _lastYCoordinate!);

      Point? screenPoints = await controller.getPoint(screenPoint);

      try {
        _userPolyLinesLatLngList.add(screenPoints!);
      } catch (e) {
        print(" error painting $e");
      }
      setState(() {});
    }
  }

  _onPanEnd(DragEndDetails details) async {
    // Reset last cached coordinate
    _lastXCoordinate = null;
    _lastYCoordinate = null;

    if (_drawPolygonEnabled) {
      //TODO add polygon here
      final mapobjectPolyGon = PolygonMapObject(
        strokeWidth: 3,
        strokeColor: Colors.blue,
        fillColor: Colors.blue[100]!,
        mapId: mapObjectId,
        polygon: Polygon(
            outerRing: LinearRing(points: _userPolyLinesLatLngList),
            innerRings: []),
      );
      List<Point> insidePoints = widget.address
          .map((e) => Point(latitude: e.latitude, longitude: e.longitude))
          .toList();
      for (var inside in insidePoints) {
        final insideList = mapobjectPolyGon.polygon.innerRings
            .where((e) => e.points.contains(inside));

        print('gijhgijhji' + '${insideList}');
      }

      setState(() {
        mapObjects.add(mapobjectPolyGon);
      });
      setState(() {
        _clearDrawing = true;
      });
    }
  }

  _clearPolygons() {
    setState(() {
      _userPolyLinesLatLngList.clear();
      mapObjects.clear();
    });
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> _cancel() async {
    await session.cancel();

    setState(() {
      _progress = false;
    });
  }

  Future<void> _close() async {
    await session.close();
  }

  Future<void> _init() async {
    await _handleResult(await result);
  }

  Future<void> _handleResult(DrivingSessionResult result) async {
    setState(() {
      _progress = false;
    });

    if (result.error != null) {
      print('Error: ${result.error}');
      return;
    }

    setState(
      () {
        results.add(result);
      },
    );
    setState(
      () {
        result.routes!.asMap().forEach(
          (i, route) {
            drivingMapObjects.add(
              PolylineMapObject(
                mapId: MapObjectId('route_${i}_polyline'),
                polyline: route.geometry,
                strokeColor:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                strokeWidth: 3,
              ),
            );
          },
        );
      },
    );
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future _requestDrivingRoutes() async {
    // print(
    //     'Points: ${startPlacemark.point},${stopByPlacemark.point},${endPlacemark.point}');
    endPlacemark = PlacemarkMapObject(
      mapId: const MapObjectId('end_placemark'),
      point: Point(latitude: endLatitude!, longitude: endLongitude!),
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('asset/flagYallow.png'),
            scale: 0.6),
      ),
    );
    startPlacemark = PlacemarkMapObject(
      mapId: const MapObjectId('start_placemark'),
      point: Point(latitude: lat!, longitude: long!),
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('asset/399308.png'),
            scale: 0.2),
      ),
    );

    var resultWithSession = await YandexDriving.requestRoutes(
      points: [
        RequestPoint(
            point: startPlacemark.point,
            requestPointType: RequestPointType.wayPoint),
        // RequestPoint(
        //     point: stopByPlacemark.point,
        //     requestPointType: RequestPointType.viaPoint),
        RequestPoint(
            point: endPlacemark.point,
            requestPointType: RequestPointType.wayPoint),
      ],
      drivingOptions: const DrivingOptions(
          initialAzimuth: 0, routesCount: 1, avoidTolls: true),
    );
    result = resultWithSession.$2;
    session = resultWithSession.$1;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => SessionPage(startPlacemark,
            endPlacemark, resultWithSession.$1, resultWithSession.$2),
      ),
    );
  }

  Future<void> _requestBicycleRoutes() async {
    // print(
    //     'Points: ${startPlacemark.point},${stopByPlacemark.point},${endPlacemark.point}');
    endPlacemark = PlacemarkMapObject(
      opacity: 10,
      mapId: const MapObjectId('end_placemark'),
      point: Point(latitude: endLatitude!, longitude: endLongitude!),
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('asset/flagYallow.png'),
            scale: 0.3),
      ),
    );
    startPlacemark = PlacemarkMapObject(
      opacity: 10,
      mapId: const MapObjectId('start_placemark'),
      point: Point(latitude: lat!, longitude: long!),
      icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage('asset/399308.png'),
          scale: 0.3)),
    );

    var resultWithSession = await YandexBicycle.requestRoutes(
      points: [
        RequestPoint(
            point: startPlacemark.point,
            requestPointType: RequestPointType.wayPoint),
        // RequestPoint(
        //     point: stopByPlacemark.point,
        //     requestPointType: RequestPointType.viaPoint),
        RequestPoint(
            point: endPlacemark.point,
            requestPointType: RequestPointType.wayPoint),
      ],
      bicycleVehicleType: BicycleVehicleType.bicycle,
    );
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BicyclePage(startPlacemark,
                endPlacemark, resultWithSession.$1, resultWithSession.$2)));
  }

  Future<void> _requestPedestrianRoutes() async {
    // print(
    //     'Points: ${startPlacemark.point},${stopByPlacemark.point},${endPlacemark.point}');
    endPlacemark = PlacemarkMapObject(
      mapId: const MapObjectId('end_placemark'),
      point: Point(latitude: endLatitude!, longitude: endLongitude!),
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('asset/flagYallow.png'),
            scale: 0.3),
      ),
    );
    startPlacemark = PlacemarkMapObject(
      opacity: 5,
      mapId: const MapObjectId('start_placemark'),
      point: Point(latitude: lat!, longitude: long!),
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage('asset/399308.png'),
          scale: 0.4,
        ),
      ),
    );

    var resultWithSession = await YandexPedestrian.requestRoutes(
      timeOptions: TimeOptions(departureTime: DateTime.now()),
      avoidSteep: true,
      points: [
        RequestPoint(
            point: startPlacemark.point,
            requestPointType: RequestPointType.wayPoint),
        // RequestPoint(
        //     point: stopByPlacemark.point,
        //     requestPointType: RequestPointType.viaPoint),
        RequestPoint(
            point: endPlacemark.point,
            requestPointType: RequestPointType.wayPoint),
      ],
    );
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => PedestrianPage(startPlacemark,
                endPlacemark, resultWithSession.$1, resultWithSession.$2)));
  }

  //method to get user's current location
  Future<LocationData> getCurrentLucation() async {
    Location location = Location();
    LocationData locationData;
    servicesEnabled = await location.serviceEnabled();
    if (!servicesEnabled) {
      servicesEnabled = await location.requestService();
      if (!servicesEnabled) {}
    }
    permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {}
    }
    locationData = await location.getLocation();

    setState(
      () {
        lat = locationData.latitude!;
        long = locationData.longitude!;
      },
    );
    return locationData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map page'),
      ),
      body: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18.0),
            child: GestureDetector(
              onPanUpdate: (_drawPolygonEnabled) ? _onPanUpdate : null,
              onPanEnd: (_drawPolygonEnabled) ? _onPanEnd : null,
              child: YandexMap(
                mapType: mapType,
                onMapTap: (argument) {
                  setState(
                    () {
                      endLatitude = argument.latitude;
                      endLongitude = argument.longitude;

                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _requestDrivingRoutes();
                                  },
                                  icon: Icon(Icons.car_rental_sharp),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _requestBicycleRoutes();
                                  },
                                  icon: Icon(Icons.bike_scooter),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _requestPedestrianRoutes();
                                  },
                                  icon: Icon(Icons.nordic_walking),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                nightModeEnabled: true,
                mapObjects: (_drawPolygonEnabled)
                    ? [
                        ...mapObjects,
                        _getClusterizedCollection(
                          placemarks: widget.address
                              .map(
                                (e) => PlacemarkMapObject(
                                  onTap: (mapObject, point) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            children: [
                                              Text('${e.username}'),
                                              Text('${e.latitude}'),
                                              Text('${e.longitude}'),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      _requestDrivingRoutes();
                                                    },
                                                    icon: Icon(
                                                        Icons.car_rental_sharp),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      _requestBicycleRoutes();
                                                    },
                                                    icon: Icon(
                                                        Icons.bike_scooter),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      _requestPedestrianRoutes();
                                                    },
                                                    icon: Icon(
                                                        Icons.nordic_walking),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                    setState(() {
                                      endLatitude = e.latitude;
                                      endLongitude = e.longitude;
                                    });
                                  },
                                  icon: PlacemarkIcon.single(
                                    PlacemarkIconStyle(
                                      //rotationType: RotationType.rotate,
                                      isFlat: true,
                                      scale: 0.6,
                                      image: BitmapDescriptor.fromAssetImage(
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
                                  consumeTapEvents: true,
                                  opacity: 3,
                                ),
                              )
                              .toList(),
                        ),
                      ]
                    : [
                        _getClusterizedCollection(
                          placemarks: widget.address
                              .map(
                                (e) => PlacemarkMapObject(
                                  onTap: (mapObject, point) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            children: [
                                              Text('${e.username}'),
                                              Text('${e.latitude}'),
                                              Text('${e.longitude}'),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      _requestDrivingRoutes();
                                                    },
                                                    icon: Icon(
                                                        Icons.car_rental_sharp),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      _requestBicycleRoutes();
                                                    },
                                                    icon: Icon(
                                                        Icons.bike_scooter),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      _requestPedestrianRoutes();
                                                    },
                                                    icon: Icon(
                                                        Icons.nordic_walking),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                    setState(() {
                                      endLatitude = e.latitude;
                                      endLongitude = e.longitude;
                                    });
                                  },
                                  icon: PlacemarkIcon.single(
                                    PlacemarkIconStyle(
                                      //rotationType: RotationType.rotate,
                                      isFlat: true,
                                      scale: 0.6,
                                      image: BitmapDescriptor.fromAssetImage(
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
                                  consumeTapEvents: true,
                                  opacity: 3,
                                ),
                              )
                              .toList(),
                        ),
                        if (lat != null)
                          currentLocationPlacemark = PlacemarkMapObject(
                            opacity: 5,
                            mapId: const MapObjectId('start_placemark'),
                            point: Point(latitude: lat!, longitude: long!),
                            icon: PlacemarkIcon.single(PlacemarkIconStyle(
                                image: BitmapDescriptor.fromAssetImage(
                                    'asset/399308.png'),
                                scale: 0.2)),
                          ),
                      ],
                onMapCreated: (_controller) {
                  controller = _controller;
                  // routeMode == 1
                  //     ? _controller.moveCamera(
                  //         CameraUpdate.newCameraPosition(
                  //           CameraPosition(
                  //             zoom: 12,
                  //             target: startPlacemark.point,
                  //           ),
                  //         ),
                  //       )
                  //     :
                  _controller.moveCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        zoom: zoom,
                        target: Point(
                            latitude: widget.address.first.latitude,
                            longitude: widget.address.first.longitude),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          //mapType buttons
          Positioned(
            top: 10,
            right: 5,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      mapType = MapType.map;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black.withOpacity(0.8), width: 2.0),
                      borderRadius: BorderRadius.circular(999),
                      color: Color(0xFFFAFAFA).withOpacity(0.6),
                    ),
                    width: 60,
                    height: 60,
                    child: Icon(
                      Icons.map,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      mapType = MapType.vector;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black.withOpacity(0.8), width: 2.0),
                      borderRadius: BorderRadius.circular(999),
                      color: Color(0xFFFAFAFA).withOpacity(0.6),
                    ),
                    width: 60,
                    height: 60,
                    child: Icon(
                      Icons.satellite,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 400,
            right: 5,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black.withOpacity(0.8), width: 2.0),
                    borderRadius: BorderRadius.circular(999),
                    color: Color(0xFFFAFAFA).withOpacity(0.6),
                  ),
                  width: 60,
                  height: 60,
                  child: IconButton(
                    onPressed: () {
                      controller.moveCamera(CameraUpdate.zoomIn());
                    },
                    icon: Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black.withOpacity(0.8), width: 2.0),
                    borderRadius: BorderRadius.circular(999),
                    color: Color(0xFFFAFAFA).withOpacity(0.6),
                  ),
                  width: 60,
                  height: 60,
                  child: IconButton(
                    onPressed: () {
                      controller.moveCamera(CameraUpdate.zoomOut());
                    },
                    icon: Icon(
                      Icons.remove,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                // Current location Button
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black.withOpacity(0.8), width: 2.0),
                    borderRadius: BorderRadius.circular(999),
                    color: Color(0xFFFAFAFA).withOpacity(0.6),
                  ),
                  width: 60,
                  height: 60,
                  child: IconButton(
                    onPressed: () async {
                      if (lat != null) {
                        await controller.moveCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              zoom: 10,
                              target: Point(latitude: lat!, longitude: long!),
                            ),
                          ),
                        );
                      }
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.navigation,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black.withOpacity(0.8), width: 2.0),
                    borderRadius: BorderRadius.circular(999),
                    color: Color(0xFFFAFAFA).withOpacity(0.6),
                  ),
                  width: 60,
                  height: 60,
                  child: IconButton(
                    onPressed: _toggleDrawing,
                    // () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (BuildContext context) => YandexPolygon(
                    //         address: widget.address,
                    //       ),
                    //     ),
                    //   );
                    //   setState(() {});
                    // },
                    icon: Icon(
                      (_drawPolygonEnabled) ? Icons.cancel : Icons.swipe_down,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 140, right: 0),
      //   child: FloatingActionButton(
      //     shape: RoundedRectangleBorder(
      //         side: BorderSide(width: 3, color: Colors.brown),
      //         borderRadius: BorderRadius.circular(100)),
      //     backgroundColor: Colors.blue,
      //     onPressed: () async {
      //       if (lat != null) {
      //         await controller.moveCamera(
      //           CameraUpdate.newCameraPosition(
      //             CameraPosition(
      //               zoom: zoom,
      //               target: Point(latitude: lat!, longitude: longt!),
      //             ),
      //           ),
      //         );
      //       }
      //       setState(() {});
      //     },
      //     child: const Icon(
      //       Icons.navigation,
      //       size: 40,
      //       color: Colors.redAccent,
      //     ),
      //   ),
      // ),
    );
  }

  ClusterizedPlacemarkCollection _getClusterizedCollection({
    required List<PlacemarkMapObject> placemarks,
  }) {
    return ClusterizedPlacemarkCollection(
        mapId: const MapObjectId('clusterized-1'),
        placemarks: placemarks,
        radius: 50,
        minZoom: 15,
        onClusterAdded: (self, cluster) async {
          return cluster.copyWith(
            appearance: cluster.appearance.copyWith(
              opacity: 1.0,
              icon: PlacemarkIcon.single(
                PlacemarkIconStyle(
                  image: BitmapDescriptor.fromBytes(
                    await ClusterIconPainter(cluster.size)
                        .getClusterIconBytes(),
                  ),
                ),
              ),
            ),
          );
        },
        onClusterTap: (self, cluster) async {
          await controller.moveCamera(
            animation: const MapAnimation(
                type: MapAnimationType.linear, duration: 0.3),
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: cluster.placemarks.first.point,
                zoom: zoom + 1,
              ),
            ),
          );
        });
  }
}

///////////////////////////   ClusterIconPainter()    ////////////////////
class ClusterIconPainter {
  const ClusterIconPainter(this.clusterSize);

  /// Number of markers in a cluster
  final int clusterSize;

  /// Method that forms a cluster figure
  /// and converts it to byte format
  Future<Uint8List> getClusterIconBytes() async {
    const size = Size(150, 150);
    final recorder = PictureRecorder();

// rendering the marker
    _paintTextCountPlacemarks(
      text: clusterSize.toString(),
      size: size,
      canvas: _paintCirclePlacemark(
        size: size,
        recorder: recorder,
      ),
    );

// conversion to byte format
    final image = await recorder.endRecording().toImage(
          size.width.toInt(),
          size.height.toInt(),
        );
    final pngBytes = await image.toByteData(format: ImageByteFormat.png);

    return pngBytes!.buffer.asUint8List();
  }
}

/////////////////// PaintTextCountPlacemarks()   ///////////////////////////
Canvas _paintCirclePlacemark({
  required Size size,
  required PictureRecorder recorder,
}) {
  final canvas = Canvas(recorder);

  final radius = size.height / 2.15;

// inner circle - shaded part of the marker
  final fillPaint = Paint()
    ..color = const Color.fromARGB(255, 187, 169, 169)
    ..style = PaintingStyle.fill;

// outer circle - marker stroke
  final strokePaint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 8;

  final circleOffset = Offset(size.height / 2, size.width / 2);

  canvas
    ..drawCircle(circleOffset, radius, fillPaint)
    ..drawCircle(circleOffset, radius, strokePaint);
  return canvas;
}

///////////////////////////  paintTextCountPlacemarks()  /////////////////////
void _paintTextCountPlacemarks({
  required String text,
  required Size size,
  required Canvas canvas,
}) {
// appearance of the text displaying the number of markers in the cluster
  final textPainter = TextPainter(
    text: TextSpan(
      text: text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 50,
        fontWeight: FontWeight.w800,
      ),
    ),
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: size.width);
// text offset
  // necessary to place text in the center of the cluster
  final textOffset = Offset(
    (size.width - textPainter.width) / 2,
    (size.height - textPainter.height) / 2,
  );
  textPainter.paint(canvas, textOffset);
}

/// Содержимое модального окна с информацией о точке на карте
class _ModalBodyView extends StatelessWidget {
  const _ModalBodyView({required this.point});

  final MapPoint point;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(point.name, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          Text(
            '${point.latitude}, ${point.longitude}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

/////////////////////////////////////////////////// draw polygon ////////////////////////
