import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:design/whereToDesign/users_model/address_model.dart';
import 'package:design/whereToDesign/yandex_map.dart';
import 'package:design/whereToDesign/yandex_map/route_custom/route_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart' as geocoder;
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../map_provider/map_provider.dart';

class FullMap2 extends ConsumerStatefulWidget {
  List<AddressModel> address;

  FullMap2({super.key, required this.address});

  @override
  ConsumerState<FullMap2> createState() => _FullMap2State();
}

class _FullMap2State extends ConsumerState<FullMap2> {
  late final YandexMapController controller;
  double zoom = 15.0;
  late final GeoObject geoObject;

  // late bool servicesEnabled;
  // late PermissionStatus permission;
  // double? lat;
  // double? long;
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
  late Future<SearchSessionResult> therResult;
  final List<SearchSessionResult> addressResults = [];
  String realAddress = 'null';

  final List<DrivingSessionResult> results = [];

  // polygon definitions //
  bool _drawPolygonEnabled = false;
  List<Point> _userPolyLinesLatLngList = [];

  bool _clearDrawing = false;
  double? _lastXCoordinate, _lastYCoordinate;
  final MapObjectId mapObjectId = const MapObjectId('polyline');
  final List<MapObject> mapObjects = [];
  late List<AddressModel> insidePolygon = [];
  List<AddressModel> newaddressInside = [];
  LineObject? line;
  // Geocoder definitions //
//ad correct key
  final geocoder.YandexGeocoder geo =
      geocoder.YandexGeocoder(apiKey: '04364003-6929-4113-b557-99bc856dcfb3');

  String address = 'null';
  String latLong = 'null';
  @override
  void initState() {
    // getCurrentLucation();
    // lat;
    // long;
    // if (lat != null) {
    //   drivingMapObjects = [startPlacemark, endPlacemark];
    // }
    mapObjectId;
    mapObjects;

    super.initState();
  }

  Future<Null> _showMyDialogNoRoute() async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text('AlertDialog Title'),
          content: const SingleChildScrollView(
            child: Center(child: Text('There are no route')),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  ////////////Initial endPlacemark
  Future _initialEndPlacmark() async {
    endPlacemark = PlacemarkMapObject(
      mapId: const MapObjectId('end_placemark'),
      point: Point(latitude: endLatitude!, longitude: endLongitude!),
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('asset/flagYallow.png'),
            scale: 0.6),
      ),
    );
    // startPlacemark = PlacemarkMapObject(
    //   mapId: const MapObjectId('start_placemark'),
    //   point: Point(latitude: lat!, longitude: long!),
    //   icon: PlacemarkIcon.single(
    //     PlacemarkIconStyle(
    //         image: BitmapDescriptor.fromAssetImage('asset/399308.png'),
    //         scale: 0.2),
    //   ),
    // );
  }

  void _search() async {
    final cameraPosition = await controller.getCameraPosition();

    print('Point: ${cameraPosition.target}, Zoom: ${cameraPosition.zoom}');

    final resultWithSession = await YandexSearch.searchByPoint(
      point: cameraPosition.target,
      zoom: cameraPosition.zoom.toInt(),
      searchOptions: const SearchOptions(
        searchType: SearchType.geo,
        geometry: false,
      ),
    );
    therResult = resultWithSession.$2;
  }

  ////////////////////////// Geocoder ////////////////////////////////////
  Future<String> convertLatLngToAddress(
      geocoder.YandexGeocoder geo, double latitude, double longitude) async {
    try {
      final geocoder.GeocodeResponse response = await geo.getGeocode(
        geocoder.ReverseGeocodeRequest(
          pointGeocode: (lat: latitude, lon: longitude),
        ),
      );

      String address = response.firstAddress?.formatted ?? 'No address found';
      return address;
    } catch (e) {
      return 'Error occurred: $e';
    }
  }
  //////////////////////////<<<<<<{polygon functions}>>>>>//////////////////////////////////////////////////

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

      x = details.localPosition.dx * 2.75;
      y = details.localPosition.dy * 2.75;

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
      setState(() {
        line = line!.copyWith(
          points: [...line!.points, details.localPosition],
        );
      });
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
        //   isPointInPolygon(inside, _userPolyLinesLatLngList);
        bool insidepoint = isPointInPolygon(inside, _userPolyLinesLatLngList);
        print('Point is ${insidepoint ? "inside" : "outside"} the polygon.');
        if (insidepoint) {
          // Add to newaddressInside list

          final newInsidePolygon = widget.address.where((element) =>
              element.latitude == inside.latitude &&
              element.longitude == inside.longitude);
          newaddressInside.addAll(newInsidePolygon);
          // newaddressInside.add(AddressModel(
          //   latitude: inside.latitude,
          //   longitude: inside.longitude,
          //   username: widget.address
          //       .firstWhere((e) =>
          //           e.latitude == inside.latitude &&
          //           e.longitude == inside.longitude)
          //       .username,
          // ));
        }
      }

      setState(() {
        mapObjects.add(mapobjectPolyGon);
      });
      setState(() {
        _clearDrawing = true;
        line = null;
      });
    }
  }

  ///////
  void _onPanStart(DragStartDetails details) {
    setState(() {
      line = LineObject(points: [details.localPosition]);
      // if (line != null) {
      //   line!.points.add(details.localPosition);
      // }
    });
  }
  /////////

  _clearPolygons() {
    setState(() {
      _userPolyLinesLatLngList.clear();
      mapObjects.clear();
      newaddressInside.clear();
    });
  }

  /////// here are functions to check if the point in the polygon ///////
  bool isPointInPolygon(Point point, List<Point> polygon) {
    int intersections = 0;
    for (int i = 0; i < polygon.length; i++) {
      Point vertex1 = polygon[i];
      Point vertex2 = polygon[(i + 1) % polygon.length];
      if (_isIntersecting(point, vertex1, vertex2)) {
        intersections++;
      }
    }
    return (intersections % 2) == 1;
  }

  bool _isIntersecting(Point point, Point vertex1, Point vertex2) {
    double px = point.longitude;
    double py = point.latitude;
    double ax = vertex1.longitude;
    double ay = vertex1.latitude;
    double bx = vertex2.longitude;
    double by = vertex2.latitude;

    if (ay > by) {
      ax = vertex2.longitude;
      ay = vertex2.latitude;
      bx = vertex1.longitude;
      by = vertex1.latitude;
    }

    if (py == ay || py == by) {
      py += 0.00001;
    }

    if ((py > by || py < ay) || (px > max(ax, bx))) {
      return false;
    }

    if (px < min(ax, bx)) {
      return true;
    }

    double red = (ax != bx) ? ((by - ay) / (bx - ax)) : double.infinity;
    double blue = (ax != px) ? ((py - ay) / (px - ax)) : double.infinity;
    return blue >= red;
  }

  ///////////////////////////////////////////<<<<{end of polygon functions}>>>>////////////////////////////////////////////////////////////////

  //method to get user's current location
  // Future<LocationData> getCurrentLucation() async {
  //   Location location = Location();
  //   LocationData locationData;
  //   servicesEnabled = await location.serviceEnabled();
  //   if (!servicesEnabled) {
  //     servicesEnabled = await location.requestService();
  //     if (!servicesEnabled) {}
  //   }
  //   permission = await location.hasPermission();
  //   if (permission == PermissionStatus.denied) {
  //     permission = await location.requestPermission();
  //     if (permission != PermissionStatus.granted) {}
  //   }
  //   locationData = await location.getLocation();

  //   setState(
  //     () {
  //       lat = locationData.latitude!;
  //       long = locationData.longitude!;
  //     },
  //   );
  //   // await _initialEndPlacmark();

  //   return locationData;
  // }

  Future<void> _initRealAddress() async {
    final cameraPosition = await controller.getCameraPosition();

    final resultWithSession = await YandexSearch.searchByPoint(
      point: cameraPosition.target,
      zoom: cameraPosition.zoom.toInt(),
      searchOptions: const SearchOptions(
        searchType: SearchType.geo,
        geometry: false,
      ),
    );
    await _handleResultRealAddress(
        await resultWithSession.$2, resultWithSession.$1);
  }

  Future<void> _handleResultRealAddress(
      SearchSessionResult result, SearchSession session) async {
    setState(() {
      _progress = false;
    });

    if (result.error != null) {
      print('Error: ${result.error}');
      return;
    }

    print('Page ${result.page}: $result');

    setState(() {
      addressResults.add(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mapHolder = ref.read(mapProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(mapProvider).drivingMapObjects.clear();
            mapHolder.bicycleMapObjects.clear();
            mapHolder.pedestrianMapObjects.clear();
            Navigator.of(context).pop();
          },
        ),
        title: Text('Full Map page'),
      ),
      body: GestureDetector(
        onPanUpdate: (_drawPolygonEnabled) ? _onPanUpdate : null,
        onPanStart: (_drawPolygonEnabled) ? _onPanStart : null,
        onPanEnd: (_drawPolygonEnabled) ? _onPanEnd : null,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18.0),
              child: YandexMap(
                mapType: mapType,
                onMapTap: (argument) async {
                  endLatitude = argument.latitude;
                  endLongitude = argument.longitude;
                  await _initRealAddress();

                  setState(
                    () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return RouteCustom(
                              endLatitude: endLatitude,
                              endLongitude: endLongitude,
                              controller: controller,
                              addressResults: addressResults);
                          // Container(
                          //   height: MediaQuery.of(context).size.height * 0.2,
                          //   width: MediaQuery.of(context).size.width,
                          //   child: Column(
                          //     children: [
                          //       Text('$endLatitude'),
                          //       Text('$endLongitude'),
                          //       Text(
                          //           'Address: ${addressResults.first.items!.first.toponymMetadata!.address.formattedAddress}'),
                          //       Row(
                          //         children: [
                          //           IconButton(
                          //             onPressed: () async {
                          //               setState(() {});
                          //               await mapHolder.requestDrivingRoutes(
                          //                 endLatitude!,
                          //                 endLongitude!,
                          //               );
                          //               setState(() {
                          //                 mapHolder.drivingMapObjects;
                          //               });
                          //               if (endLatitude != null) {
                          //                 await controller.moveCamera(
                          //                   CameraUpdate.newCameraPosition(
                          //                     CameraPosition(
                          //                       zoom: 10,
                          //                       target: Point(
                          //                           latitude: mapHolder.lat!,
                          //                           longitude: mapHolder.long!),
                          //                     ),
                          //                   ),
                          //                 );
                          //               }
                          //               Navigator.of(context).pop();
                          //             },
                          //             icon: Icon(Icons.directions_car),
                          //           ),
                          //           IconButton(
                          //             onPressed: () async {
                          //               setState(() {});
                          //               await mapHolder
                          //                   .requestBicycleRoutes(
                          //                 endLatitude!,
                          //                 endLongitude!,
                          //               )
                          //                   .then((value) {
                          //                 if (value.routes == null ||
                          //                     value.routes!.isEmpty == true) {
                          //                   _showMyDialogNoRoute();
                          //                 } else {
                          //                   Navigator.of(context).pop();
                          //                 }
                          //               });
                          //               setState(() {
                          //                 mapHolder.bicycleMapObjects;
                          //               });

                          //               if (endLatitude != null) {
                          //                 await controller.moveCamera(
                          //                   CameraUpdate.newCameraPosition(
                          //                     CameraPosition(
                          //                       zoom: 10,
                          //                       target: Point(
                          //                           latitude: lat!,
                          //                           longitude: long!),
                          //                     ),
                          //                   ),
                          //                 );
                          //               }

                          //               //Navigator.of(context).pop();
                          //             },
                          //             icon: Icon(Icons.directions_bike),
                          //           ),
                          //           IconButton(
                          //             onPressed: () async {
                          //               // _requestPedestrianRoutes();

                          //               setState(() {});
                          //               await mapHolder
                          //                   .requestPedestrianRoutes(
                          //                 endLatitude!,
                          //                 endLongitude!,
                          //               )
                          //                   .then((value) {
                          //                 if (value.routes == null ||
                          //                     value.routes!.isEmpty == true) {
                          //                   _showMyDialogNoRoute();
                          //                 } else {
                          //                   Navigator.of(context).pop();
                          //                 }
                          //               });
                          //               setState(() {
                          //                 mapHolder.pedestrianMapObjects;
                          //               });

                          //               if (endLatitude != null) {
                          //                 await controller.moveCamera(
                          //                   CameraUpdate.newCameraPosition(
                          //                     CameraPosition(
                          //                       zoom: 10,
                          //                       target: Point(
                          //                           latitude: lat!,
                          //                           longitude: long!),
                          //                     ),
                          //                   ),
                          //                 );
                          //               }
                          //             },
                          //             icon: Icon(Icons.directions_walk),
                          //           ),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // );
                        },
                      );
                    },
                  );
                  // final geocoder.GeocodeResponse _address =
                  //     await geo.getGeocode(
                  //   geocoder.ReverseGeocodeRequest(
                  //     pointGeocode: (lat: endLatitude!, lon: endLongitude!),
                  //   ),
                  // );
                  // address = _address.firstAddress?.formatted ?? 'null';

                  // final geocoder.GeocodeResponse _latLong =
                  //     await geo.getGeocode(
                  //   geocoder.DirectGeocodeRequest(
                  //     addressGeocode: 'Москва, 4-я Тверская-Ямская улица, 7',
                  //   ),
                  // );

                  // latLong = _latLong.firstPoint.toString();
                },
                nightModeEnabled: true,
                mapObjects: (_drawPolygonEnabled)
                    ? [
                        // This is polygon MapOpject show
                        ...mapHolder.drivingMapObjects,
                        ...mapHolder.bicycleMapObjects,
                        ...mapHolder.pedestrianMapObjects,
                        ...mapObjects, //this is polygon MapObject
                        _getClusterizedCollection(
                          placemarks: newaddressInside
                              .map(
                                (e) => PlacemarkMapObject(
                                  onTap: (mapObject, point) async {
                                    // await _initialEndPlacmark();
                                    await _initRealAddress();
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
                                              Text(
                                                  'Address: ${addressResults.first.items!.first.toponymMetadata!.address.formattedAddress}'),
                                              Row(
                                                children: [
                                                  // IconButton(
                                                  //   onPressed: () async {
                                                  //     setState(() {});
                                                  //     await mapHolder
                                                  //         .requestDrivingRoutes(
                                                  //       lat!,
                                                  //       long!,
                                                  //       e.latitude,
                                                  //       e.longitude,
                                                  //     );
                                                  //     setState(() {
                                                  //       mapHolder
                                                  //           .drivingMapObjects;
                                                  //     });
                                                  //     await controller
                                                  //         .moveCamera(
                                                  //       CameraUpdate
                                                  //           .newCameraPosition(
                                                  //         CameraPosition(
                                                  //           zoom: 10,
                                                  //           target: Point(
                                                  //               latitude: lat!,
                                                  //               longitude:
                                                  //                   long!),
                                                  //         ),
                                                  //       ),
                                                  //     );
                                                  //   },
                                                  //   icon: const Icon(
                                                  //       Icons.directions_car),
                                                  // ),
                                                  // IconButton(
                                                  //   onPressed: () {
                                                  //     // _requestBicycleRoutes();
                                                  //   },
                                                  //   icon: Icon(
                                                  //       Icons.directions_bike),
                                                  // ),
                                                  // IconButton(
                                                  //   onPressed: () {
                                                  //     //  _requestPedestrianRoutes();
                                                  //   },
                                                  //   icon: Icon(
                                                  //       Icons.directions_walk),
                                                  // ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                    // setState(() {
                                    //   endLatitude = e.latitude;
                                    //   endLongitude = e.longitude;
                                    // });
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
                    // : endLatitude != null
                    //     ? [
                    //         ...mapHolder.drivingMapObjects,
                    //         ...mapHolder.bicycleMapObjects,
                    //         ...mapHolder.pedestrianMapObjects
                    //       ]
                    : [
                        ...mapHolder.drivingMapObjects,
                        ...mapHolder.bicycleMapObjects,
                        ...mapHolder.pedestrianMapObjects,
                        // This is location mark MapOpject

                        _getClusterizedCollection(
                          placemarks: widget.address
                              .map(
                                (e) => PlacemarkMapObject(
                                  onTap: (mapObject, point) {
                                    // setState(() {
                                    //   mapHolder.drivingMapObjects.clear();
                                    //   mapHolder.bicycleMapObjects.clear();
                                    //   mapHolder.pedestrianMapObjects
                                    //       .clear();
                                    // });
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
                                                  // IconButton(
                                                  //   onPressed: () async {
                                                  //     setState(() {});
                                                  //     await mapHolder
                                                  //         .requestDrivingRoutes(
                                                  //       e.latitude,
                                                  //       e.longitude,
                                                  //     );
                                                  //     setState(() {
                                                  //       mapHolder
                                                  //           .drivingMapObjects;
                                                  //     });

                                                  //     await controller
                                                  //         .moveCamera(
                                                  //       CameraUpdate
                                                  //           .newCameraPosition(
                                                  //         CameraPosition(
                                                  //           zoom: 10,
                                                  //           target: Point(
                                                  //               latitude: lat!,
                                                  //               longitude:
                                                  //                   long!),
                                                  //         ),
                                                  //       ),
                                                  //     );

                                                  //     Navigator.of(context)
                                                  //         .pop();
                                                  //   },
                                                  //   icon: Icon(
                                                  //       Icons.directions_car),
                                                  // ),
                                                  // IconButton(
                                                  //   onPressed: () async {
                                                  //     setState(() {});
                                                  //     await mapHolder
                                                  //         .requestBicycleRoutes(
                                                  //       e.latitude,
                                                  //       e.longitude,
                                                  //     )
                                                  //         .then((value) {
                                                  //       if (value.routes ==
                                                  //               null ||
                                                  //           value.routes!
                                                  //                   .isEmpty ==
                                                  //               true) {
                                                  //         _showMyDialogNoRoute();
                                                  //       } else {
                                                  //         Navigator.of(context)
                                                  //             .pop();
                                                  //       }
                                                  //     });
                                                  //     setState(
                                                  //       () {
                                                  //         mapHolder
                                                  //             .bicycleMapObjects;
                                                  //       },
                                                  //     );

                                                  //     await controller
                                                  //         .moveCamera(
                                                  //       CameraUpdate
                                                  //           .newCameraPosition(
                                                  //         CameraPosition(
                                                  //           zoom: 10,
                                                  //           target: Point(
                                                  //               latitude: lat!,
                                                  //               longitude:
                                                  //                   long!),
                                                  //         ),
                                                  //       ),
                                                  //     );
                                                  //   },
                                                  //   icon: Icon(
                                                  //       Icons.directions_bike),
                                                  // ),
                                                  // IconButton(
                                                  //   onPressed: () async {
                                                  //     // _requestPedestrianRoutes();
                                                  //     setState(() {});
                                                  //     await mapHolder
                                                  //         .requestPedestrianRoutes(
                                                  //       e.latitude,
                                                  //       e.longitude,
                                                  //     )
                                                  //         .then((value) {
                                                  //       if (value.routes ==
                                                  //               null ||
                                                  //           value.routes!
                                                  //                   .isEmpty ==
                                                  //               true) {
                                                  //         _showMyDialogNoRoute();
                                                  //       } else {
                                                  //         Navigator.of(context)
                                                  //             .pop();
                                                  //       }
                                                  //     });
                                                  //     setState(() {
                                                  //       mapHolder
                                                  //           .pedestrianMapObjects;
                                                  //     });

                                                  //     await controller
                                                  //         .moveCamera(
                                                  //       CameraUpdate
                                                  //           .newCameraPosition(
                                                  //         CameraPosition(
                                                  //           zoom: 10,
                                                  //           target: Point(
                                                  //               latitude: lat!,
                                                  //               longitude:
                                                  //                   long!),
                                                  //         ),
                                                  //       ),
                                                  //     );
                                                  //   },
                                                  //   icon: Icon(
                                                  //       Icons.directions_walk),
                                                  // ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
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
                        if (mapHolder.lat != null)
                          currentLocationPlacemark = PlacemarkMapObject(
                            opacity: 5,
                            mapId: const MapObjectId('start_placemark'),
                            point: Point(
                                latitude: mapHolder.lat!,
                                longitude: mapHolder.long!),
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
            if (line != null)
              CustomPaint(
                size: MediaQuery.sizeOf(context),
                painter: FingerPainter(
                  line: line!,
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
                        if (mapHolder.lat != null) {
                          await controller.moveCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                zoom: 10,
                                target: Point(
                                    latitude: mapHolder.lat!,
                                    longitude: mapHolder.long!),
                              ),
                            ),
                          );
                        }
                        setState(() {});
                      },
                      icon: const Icon(
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

///////////////////////////// draw line ///////////////////////////////
class LineObject {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;

  const LineObject({
    required this.points,
    this.color = Colors.red,
    this.strokeWidth = 20.0,
  });

  LineObject copyWith({
    List<Offset>? points,
    Color? color,
    double? strokeWidth,
  }) {
    return LineObject(
      points: points ?? this.points,
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }
}

class FingerPainter extends CustomPainter {
  final LineObject line;
  const FingerPainter({
    required this.line,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = line.color
      ..strokeWidth = line.strokeWidth
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < line.points.length - 1; i++) {
      canvas.drawLine(line.points[i], line.points[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(FingerPainter oldDelegate) {
    return line.points.length != oldDelegate.line.points.length;
  }
}
