import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:design/whereToDesign/models/address_model.dart';
import 'package:design/whereToDesign/models/boat_model.dart';
import 'package:design/whereToDesign/show_information_new.dart';
import 'package:design/whereToDesign/yandex_map.dart';
import 'package:design/whereToDesign/yandex_map/route_custom/route_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart' as geocoder;
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../change_notifier/boat_provider_change_notifire.dart';
import '../map_provider/map_change_notifier_provider.dart';
import '../map_provider/map_provider.dart';

class ShowAllElementsOnMapSecond extends ConsumerStatefulWidget {
  // List<AddressModel> address;

  ShowAllElementsOnMapSecond({
    super.key,
    //required this.address
  });

  @override
  ConsumerState<ShowAllElementsOnMapSecond> createState() => _FullMap2State();
}

class _FullMap2State extends ConsumerState<ShowAllElementsOnMapSecond> {
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
  bool _drawPolygonEnabledSecond = false;
  List<Point> _userPolyLinesLatLngList = [];
  List<Point> _userPolyLinesLatLngListSecond = [];

  bool _clearDrawing = false;
  bool _clearDrawingSecond = false;
  double? _lastXCoordinate, _lastYCoordinate;
  final MapObjectId mapObjectId = const MapObjectId('polyline');
  final MapObjectId mapObjectIdSecond = const MapObjectId('secondPolyline');
  final List<MapObject> mapObjects = [];
  final List<MapObject> mapObjectsSecond = [];
  // late List<AddressModel> insidePolygon = [];
  late List<AddressModel> insidePolygonSecond = [];
  List<AddressModel> newaddressInside = [];
  List<AddressModel> newaddressInsideSecond = [];
  List<BoatModel> boatListInsidePolygon = [];
  List<BoatModel> boatListInsidePolygonSecond = [];
  LineObject? line;
  LineObject? line2;
  bool allowSecond = false;
  bool banMultiDrawFirst = false;
  bool banMultiDrawSecond = false;

  // Geocoder definitions //
//ad correct key
  final geocoder.YandexGeocoder geo = geocoder.YandexGeocoder(
      apiKey: '04364003-6929-4113-b557-99bc856dcfb3'); //

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
    mapObjectsSecond;
    mapObjectIdSecond;
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
            image: BitmapDescriptor.fromAssetImage('assets/flagYallow.png'),
            scale: 0.6),
      ),
    );
    // startPlacemark = PlacemarkMapObject(
    //   mapId: const MapObjectId('start_placemark'),
    //   point: Point(latitude: lat!, longitude: long!),
    //   icon: PlacemarkIcon.single(
    //     PlacemarkIconStyle(
    //         image: BitmapDescriptor.fromAssetImage('assets/399308.png'),
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
    setState(() {
      banMultiDrawFirst = false;
    });
  }

  //
  _toggleDrawingSecond() {
    _clearPolygonsSecond();
    setState(() => _drawPolygonEnabledSecond = !_drawPolygonEnabledSecond);
    setState(() {
      banMultiDrawSecond = false;
    });
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
        if (line != null) {
          line = line!.copyWith(
            points: [...line!.points, details.localPosition],
          );
        }
      });
    }
  }

  //Second>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  _onPanUpdateSecond(DragUpdateDetails details) async {
    // To start draw new polygon every time.
    if (_clearDrawingSecond) {
      _clearDrawingSecond = false;
      _clearPolygonsSecond();
    }

    if (_drawPolygonEnabledSecond) {
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
        _userPolyLinesLatLngListSecond.add(screenPoints!);
      } catch (e) {
        print(" error painting $e");
      }
      setState(() {
        line2 = line2!.copyWith(
          points: [...line2!.points, details.localPosition],
        );
      });
    }
  }

  _onPanEnd(DragEndDetails details) async {
    // Reset last cached coordinate
    _lastXCoordinate = null;
    _lastYCoordinate = null;
    final boatListHolder = ref.watch(boatProviderChangeNotifier);

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
      // Convert boatListHolder.boatList's addresses to a list of Point objects
      List<Point> insidePoints = boatListHolder.boatList
          .expand((boatlist) => boatlist.address
              .map((e) => Point(latitude: e.latitude, longitude: e.longitude)))
          .toList();

      // Check each point inside the polygon and add those that are inside to the newaddressInside list
      for (var inside in insidePoints) {
        bool insidepoint = isPointInPolygon(inside, _userPolyLinesLatLngList);
        print('Point is ${insidepoint ? "inside" : "outside"} the polygon.');

        if (insidepoint) {
          // Add matching points to newaddressInside list
          final newInsidePolygon = boatListHolder.boatList.expand((boatlist) =>
              boatlist.address.where((element) =>
                  element.latitude == inside.latitude &&
                  element.longitude == inside.longitude));

          newaddressInside.addAll(newInsidePolygon);
        }
      }

      setState(() {
        mapObjects.add(mapobjectPolyGon);
      });
      setState(() {
        _clearDrawing = true;
        line = null;
        banMultiDrawFirst = true;
      });

      // _drawPolygonEnabled = false; .
    }
  }

  ////Second>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  _onPanEndSecond(DragEndDetails details) async {
    // Reset last cached coordinate
    _lastXCoordinate = null;
    _lastYCoordinate = null;
    final boatListHolder = ref.watch(boatProviderChangeNotifier);

    if (_drawPolygonEnabledSecond) {
      //TODO add polygon here
      final mapobjectPolyGonSecond = PolygonMapObject(
        strokeWidth: 3,
        strokeColor: Colors.blue,
        fillColor: Colors.blue[100]!,
        mapId: mapObjectIdSecond,
        polygon: Polygon(
            outerRing: LinearRing(points: _userPolyLinesLatLngListSecond),
            innerRings: []),
      );
      // Convert boatListHolder.boatList's addresses to a list of Point objects
      List<Point> insidePoints = boatListHolder.boatList
          .expand((boatlist) => boatlist.address
              .map((e) => Point(latitude: e.latitude, longitude: e.longitude)))
          .toList();

      // Check each point inside the polygon and add those that are inside to the newaddressInside list
      for (var inside in insidePoints) {
        bool insidepoint =
            isPointInPolygonSecond(inside, _userPolyLinesLatLngListSecond);
        print('Point is ${insidepoint ? "inside" : "outside"} the polygon.');

        if (insidepoint) {
          // Add matching points to newaddressInside list
          final newInsidePolygon = boatListHolder.boatList.expand((boatlist) =>
              boatlist.address.where((element) =>
                  element.latitude == inside.latitude &&
                  element.longitude == inside.longitude));

          newaddressInsideSecond.addAll(newInsidePolygon);
        }
      }

      setState(() {
        mapObjectsSecond.add(mapobjectPolyGonSecond);
      });
      setState(() {
        _clearDrawingSecond = true;
        line2 = null;
        banMultiDrawSecond = true;
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

  ////Second>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  void _onPanStartSecond(DragStartDetails details) {
    setState(() {
      line2 = LineObject(points: [details.localPosition]);
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
      //  mapObjectsSecond.clear();
      newaddressInside.clear();
    });
  }

  _clearPolygonsSecond() {
    setState(() {
      _userPolyLinesLatLngListSecond.clear();
      // _userPolyLinesLatLngList.clear();
      //  mapObjects.clear();
      mapObjectsSecond.clear();
      newaddressInsideSecond.clear();
      //  newaddressInside.clear();
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

  /////// here are functions to check if the point in the second polygon ///////
  bool isPointInPolygonSecond(Point point, List<Point> polygon) {
    int intersections = 0;
    for (int i = 0; i < polygon.length; i++) {
      Point vertex1 = polygon[i];
      Point vertex2 = polygon[(i + 1) % polygon.length];
      if (_isIntersectingSecond(point, vertex1, vertex2)) {
        intersections++;
      }
    }
    return (intersections % 2) == 1;
  }

  bool _isIntersectingSecond(Point point, Point vertex1, Point vertex2) {
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

  @override
  Widget build(BuildContext context) {
    final boatListHolder = ref.read(boatProviderChangeNotifier);

    final mapHolder = ref.watch(mapProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(mapProvider).drivingMapObjects.clear();
            mapHolder.bicycleMapObjects.clear();
            mapHolder.pedestrianMapObjects.clear();
            //  Navigator.of(context).pop();
          },
        ),
        title: Text('Full Map page'),
      ),
      body: GestureDetector(
        onPanUpdate: (_drawPolygonEnabled == true && banMultiDrawFirst == false
            // &&
            // _drawPolygonEnabledSecond == false
            )
            ? _onPanUpdate
            : (_drawPolygonEnabledSecond == true && banMultiDrawSecond == false)
                ? _onPanUpdateSecond
                : null,
        onPanStart: (_drawPolygonEnabled == true && banMultiDrawFirst == false
            // &&
            // _drawPolygonEnabledSecond == false
            )
            ? _onPanStart
            : (_drawPolygonEnabledSecond == true && banMultiDrawSecond == false)
                ? _onPanStartSecond
                : null,
        onPanEnd: (_drawPolygonEnabled == true && banMultiDrawFirst == false
            // &&
            // _drawPolygonEnabledSecond == false
            )
            ? _onPanEnd
            : (_drawPolygonEnabledSecond == true && banMultiDrawSecond == false)
                ? _onPanEndSecond
                : null,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18.0),
              child: YandexMap(
                mapType: mapType,
                onMapTap: (argument) async {
                  mapHolder.drivingMapObjects.clear();
                  mapHolder.bicycleMapObjects.clear();
                  mapHolder.pedestrianMapObjects.clear();
                  endLatitude = argument.latitude;
                  endLongitude = argument.longitude;
                  //      await _initRealAddress();
                  final mapChangeNotiProvider =
                      ref.read(mapChangeNotifierProvider);
                  // call the function givValues() to set values to the >>endLatitude, endLongitude, controller, addressResults
                  // in provider to use it in RouteCustom page.
                  mapChangeNotiProvider.givValues(
                    endLatitude,
                    endLongitude,
                    controller,
                    // addressResults,
                  );

                  //
                  await showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return RouteCustom(
                        endLatitude: endLatitude,
                        endLongitude: endLongitude,
                        controller: controller,
                        //   addressResults: addressResults,
                      );
                    },
                  );
                  // Navigator.of(context).pop();
                },
                nightModeEnabled: true,
                mapObjects:
                    (_drawPolygonEnabled == true ||
                            _drawPolygonEnabledSecond == true)
                        ? [
                            // This is first polygon MapOpjects show
                            // here is the cluster and marks inside the first polygon
                            ...mapHolder.drivingMapObjects,
                            ...mapHolder.bicycleMapObjects,
                            ...mapHolder.pedestrianMapObjects,
                            ...mapObjects, //this is first polygon MapObject
                            ...mapObjectsSecond, //this is second polygon MapObject
                            //
                            _getClusterizedCollection(
                                // this is the cluster for first polygon
                                placemarks: newaddressInside
                                    .map(
                                      (e) => PlacemarkMapObject(
                                        onTap: (mapObject, point) async {
                                          // await _initialEndPlacmark();
                                          //    await _initRealAddress();
                                          if (boatListInsidePolygon
                                              .isNotEmpty) {
                                            boatListInsidePolygon.clear();
                                          }
                                          boatListInsidePolygon.addAll(
                                              boatListHolder.boatList.where(
                                                  (boat) => boat.address
                                                      .contains(e)));

                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                height: 800,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      // Display the username, latitude, longitude
                                                      ...boatListInsidePolygon
                                                          .map(
                                                              (boatlist) =>
                                                                  InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      final boatListHolder =
                                                                          ref.read(
                                                                              boatProviderChangeNotifier);
                                                                      await boatListHolder
                                                                          .getElemenIndex(
                                                                              boatlist);
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              ShowInformationNew(),
                                                                        ),
                                                                      );
                                                                    },
                                                                    child: Card(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade800,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 200,
                                                                              child: ListView.builder(
                                                                                  scrollDirection: Axis.horizontal,
                                                                                  itemCount: boatlist.imageList.length,
                                                                                  itemBuilder: (context, index) {
                                                                                    return Padding(
                                                                                      padding: const EdgeInsets.all(5),
                                                                                      child: ClipRRect(
                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                        child: Image.network(
                                                                                          boatlist.imageList[index],
                                                                                          width: 250,
                                                                                          height: 200,
                                                                                          fit: BoxFit.cover,
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  }),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Icon(Icons.radar),
                                                                                const SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                Text(boatlist.boatName),
                                                                                Spacer(),
                                                                                // ...List.generate(
                                                                                //   boatInside.rating.toInt(),
                                                                                //   (index) => Icon(
                                                                                //     size: 15,
                                                                                //     Icons.star,
                                                                                //     color: Colors.yellow,
                                                                                //   ),
                                                                                // ),
                                                                                Row(
                                                                                  children: [
                                                                                    // Full stars
                                                                                    ...List.generate(
                                                                                      boatlist.rating.floor(), // Full stars based on the integer part of the rating
                                                                                      (index) => Icon(
                                                                                        size: 15,
                                                                                        Icons.star,
                                                                                        color: Colors.yellow,
                                                                                      ),
                                                                                    ),
                                                                                    // Half star if there's a decimal part (e.g., 2.5)
                                                                                    if (boatlist.rating - boatlist.rating.floor() >= 0.5)
                                                                                      Icon(
                                                                                        size: 15,
                                                                                        Icons.star_half,
                                                                                        color: Colors.yellow,
                                                                                      ),
                                                                                    // Empty stars for the remaining
                                                                                    ...List.generate(
                                                                                      5 - boatlist.rating.ceil(), // Remaining empty stars
                                                                                      (index) => Icon(
                                                                                        size: 15,
                                                                                        Icons.star_border,
                                                                                        color: Colors.yellow,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(width: 10),
                                                                                Text(boatlist.rating.toString())
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Icon(Icons.group),
                                                                                const SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                Text('To ${boatlist.guests} Guests')
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Text('From ${boatlist.minimumPrice.toString()} P/hour')
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )),
                                                    ],
                                                  ),
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
                                            image:
                                                BitmapDescriptor.fromAssetImage(
                                                    'assets/markicon.png'),
                                          ),
                                        ),
                                        // it must be unique to show all
                                        mapId: MapObjectId(
                                            e.latitude.toString() +
                                                e.longitude.toString()),
                                        point: Point(
                                            latitude: e.latitude,
                                            longitude: e.longitude),
                                        consumeTapEvents: true,
                                        opacity: 3,
                                      ),
                                    )
                                    .toList(),
                                boatList: boatListHolder.boatList),
                            ////////////////////////////////////////////////////////////////////////////////////
                            // here is the Cluster of the second polygon
                            _getClusterizedCollectionSecond(
                                // here is the Cluster of the second polygon
                                placemarks: newaddressInsideSecond
                                    .map(
                                      (e) => PlacemarkMapObject(
                                        onTap: (mapObject, point) async {
                                          // await _initialEndPlacmark();
                                          //    await _initRealAddress();
                                          if (boatListInsidePolygonSecond
                                              .isNotEmpty) {
                                            boatListInsidePolygonSecond.clear();
                                          }

                                          boatListInsidePolygonSecond.addAll(
                                              boatListHolder.boatList.where(
                                                  (boat) => boat.address
                                                      .contains(e)));

                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                height: 800,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      // Display the username, latitude, longitude
                                                      ...boatListInsidePolygonSecond
                                                          .map(
                                                              (boatlist) =>
                                                                  InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      final boatListHolder =
                                                                          ref.read(
                                                                              boatProviderChangeNotifier);
                                                                      await boatListHolder
                                                                          .getElemenIndex(
                                                                              boatlist);
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              ShowInformationNew(),
                                                                        ),
                                                                      );
                                                                    },
                                                                    child: Card(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade800,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 200,
                                                                              child: ListView.builder(
                                                                                  scrollDirection: Axis.horizontal,
                                                                                  itemCount: boatlist.imageList.length,
                                                                                  itemBuilder: (context, index) {
                                                                                    return Padding(
                                                                                      padding: const EdgeInsets.all(5),
                                                                                      child: ClipRRect(
                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                        child: Image.network(
                                                                                          boatlist.imageList[index],
                                                                                          width: 250,
                                                                                          height: 200,
                                                                                          fit: BoxFit.cover,
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  }),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Icon(Icons.radar),
                                                                                const SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                Text(boatlist.boatName),
                                                                                Spacer(),
                                                                                // ...List.generate(
                                                                                //   boatInside.rating.toInt(),
                                                                                //   (index) => Icon(
                                                                                //     size: 15,
                                                                                //     Icons.star,
                                                                                //     color: Colors.yellow,
                                                                                //   ),
                                                                                // ),
                                                                                Row(
                                                                                  children: [
                                                                                    // Full stars
                                                                                    ...List.generate(
                                                                                      boatlist.rating.floor(), // Full stars based on the integer part of the rating
                                                                                      (index) => Icon(
                                                                                        size: 15,
                                                                                        Icons.star,
                                                                                        color: Colors.yellow,
                                                                                      ),
                                                                                    ),
                                                                                    // Half star if there's a decimal part (e.g., 2.5)
                                                                                    if (boatlist.rating - boatlist.rating.floor() >= 0.5)
                                                                                      Icon(
                                                                                        size: 15,
                                                                                        Icons.star_half,
                                                                                        color: Colors.yellow,
                                                                                      ),
                                                                                    // Empty stars for the remaining
                                                                                    ...List.generate(
                                                                                      5 - boatlist.rating.ceil(), // Remaining empty stars
                                                                                      (index) => Icon(
                                                                                        size: 15,
                                                                                        Icons.star_border,
                                                                                        color: Colors.yellow,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(width: 10),
                                                                                Text(boatlist.rating.toString())
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Icon(Icons.group),
                                                                                const SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                Text('To ${boatlist.guests} Guests')
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Text('From ${boatlist.minimumPrice.toString()} P/hour')
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )),
                                                    ],
                                                  ),
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
                                            image:
                                                BitmapDescriptor.fromAssetImage(
                                                    'assets/markicon.png'),
                                          ),
                                        ),
                                        // it must be unique to show all
                                        mapId: MapObjectId(
                                            e.latitude.toString() +
                                                e.longitude.toString()),
                                        point: Point(
                                            latitude: e.latitude,
                                            longitude: e.longitude),
                                        consumeTapEvents: true,
                                        opacity: 3,
                                      ),
                                    )
                                    .toList(),
                                boatList: boatListHolder.boatList),
                          ]
                        : [
                            // here is the cluster and marks outside the Polygon
                            ...mapHolder.drivingMapObjects,
                            ...mapHolder.bicycleMapObjects,
                            ...mapHolder.pedestrianMapObjects,
                            // This is location mark MapOpject
                            _getClusterizedCollection(
                              placemarks: boatListHolder.boatList
                                  .expand(
                                      (boatlist) =>
                                          boatlist.address
                                              .map((e) => PlacemarkMapObject(
                                                    onTap: (mapObject,
                                                        point) async {
                                                      // Initialize address or any other data you need
                                                      //     await _initRealAddress();

                                                      // Display the bottom sheet with information about the placemark and boat
                                                      showModalBottomSheet(
                                                        context: context,
                                                        builder: (context) {
                                                          return InkWell(
                                                            onTap: () async {
                                                              final boatListHolder =
                                                                  ref.read(
                                                                      boatProviderChangeNotifier);
                                                              await boatListHolder
                                                                  .getElemenIndex(
                                                                      boatlist);
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ShowInformationNew(),
                                                                ),
                                                              );
                                                            },
                                                            child: Container(
                                                              height: 800,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Column(
                                                                  children: [
                                                                    // Display the username, latitude, longitude
                                                                    Card(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade800,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 200,
                                                                              child: ListView.builder(
                                                                                  scrollDirection: Axis.horizontal,
                                                                                  itemCount: boatlist.imageList.length,
                                                                                  itemBuilder: (context, index) {
                                                                                    return Padding(
                                                                                      padding: const EdgeInsets.all(5),
                                                                                      child: ClipRRect(
                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                        child: Image.network(
                                                                                          boatlist.imageList[index],
                                                                                          width: 250,
                                                                                          height: 200,
                                                                                          fit: BoxFit.cover,
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  }),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Icon(Icons.radar),
                                                                                const SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                Text(boatlist.boatName),
                                                                                Spacer(),
                                                                                // ...List.generate(
                                                                                //   boatInside.rating.toInt(),
                                                                                //   (index) => Icon(
                                                                                //     size: 15,
                                                                                //     Icons.star,
                                                                                //     color: Colors.yellow,
                                                                                //   ),
                                                                                // ),
                                                                                Row(
                                                                                  children: [
                                                                                    // Full stars
                                                                                    ...List.generate(
                                                                                      boatlist.rating.floor(), // Full stars based on the integer part of the rating
                                                                                      (index) => Icon(
                                                                                        size: 15,
                                                                                        Icons.star,
                                                                                        color: Colors.yellow,
                                                                                      ),
                                                                                    ),
                                                                                    // Half star if there's a decimal part (e.g., 2.5)
                                                                                    if (boatlist.rating - boatlist.rating.floor() >= 0.5)
                                                                                      Icon(
                                                                                        size: 15,
                                                                                        Icons.star_half,
                                                                                        color: Colors.yellow,
                                                                                      ),
                                                                                    // Empty stars for the remaining
                                                                                    ...List.generate(
                                                                                      5 - boatlist.rating.ceil(), // Remaining empty stars
                                                                                      (index) => Icon(
                                                                                        size: 15,
                                                                                        Icons.star_border,
                                                                                        color: Colors.yellow,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(width: 10),
                                                                                Text(boatlist.rating.toString())
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Icon(Icons.group),
                                                                                const SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                Text('To ${boatlist.guests} Guests')
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Text('From ${boatlist.minimumPrice.toString()} P/hour')
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    icon: PlacemarkIcon.single(
                                                      PlacemarkIconStyle(
                                                        isFlat: true,
                                                        scale: 0.6,
                                                        image: BitmapDescriptor
                                                            .fromAssetImage(
                                                                'assets/markicon.png'), // Ensure the asset exists
                                                      ),
                                                    ),
                                                    mapId: MapObjectId(e
                                                            .latitude
                                                            .toString() +
                                                        e.longitude.toString()),
                                                    point: Point(
                                                      latitude: e.latitude,
                                                      longitude: e.longitude,
                                                    ),
                                                    consumeTapEvents: true,
                                                    opacity:
                                                        1, // Consider adjusting opacity to valid value
                                                  )))
                                  .toList(), // Flatten the list of PlacemarkMapObjects
                              boatList: boatListHolder.boatList,
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
                                        'assets/399308.png'),
                                    scale: 0.2)),
                              ),
                          ],
                onMapCreated: (_controller) {
                  controller = _controller;
                },
              ),
            ),
            // if (line != null)
            // if ((banMultiDrawFirst == false || banMultiDrawSecond == false) &&
            //     line != null &&
            //     line2 != null)
            //if (line != null || line2 != null)
            // here we are setting condition to check the line, is it from first polygon or from second.
            if ((_drawPolygonEnabled == true) && line != null)
              CustomPaint(
                size: MediaQuery.sizeOf(context),
                painter: FingerPainter(line: line!),
              ),
            if ((_drawPolygonEnabledSecond == true) && line2 != null)
              CustomPaint(
                size: MediaQuery.sizeOf(context),
                painter: FingerPainter(
                  line: line2!,
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
              top: 350,
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
                        await mapHolder.getCurrentLucation();
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
                  // here is the first polygon
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
                        setState(() {});
                        _toggleDrawing();
                      },
                      icon: Icon(
                        (_drawPolygonEnabled) ? Icons.cancel : Icons.swipe_down,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // here is the second polygon
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
                      onPressed: _toggleDrawingSecond,
                      icon: Icon(
                        (_drawPolygonEnabledSecond)
                            ? Icons.cancel
                            : Icons.swipe_down,
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
    );
  }

  // here is the cluster function for first polygon.
  ClusterizedPlacemarkCollection _getClusterizedCollection({
    required List<PlacemarkMapObject> placemarks,
    required List<BoatModel> boatList,
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
                  await ClusterIconPainter(cluster.size).getClusterIconBytes(),
                ),
              ),
            ),
          ),
        );
      },
      onClusterTap: (self, cluster) async {
        // await controller.moveCamera(
        //   animation:
        //       const MapAnimation(type: MapAnimationType.linear, duration: 0.3),
        //   CameraUpdate.newCameraPosition(
        //     CameraPosition(
        //       target: cluster.placemarks.first.point,
        //       zoom: zoom + 1,
        //     ),
        //   ),
        // );
        // List<BoatModel> boatListInside = [];
        // for (var inside in boatList) {
        //   if (inside.address.any((e) =>
        //       e.latitude == cluster.placemarks.first.point.latitude &&
        //       e.longitude == cluster.placemarks.first.point.longitude)) {
        //     boatListInside.add(inside);
        //   }
        // }
        List<BoatModel> boatListInside = [];
        for (var inside in boatList) {
          for (var placemark in cluster.placemarks) {
            if (inside.address.any((e) =>
                e.latitude == placemark.point.latitude &&
                e.longitude == placemark.point.longitude)) {
              if (!boatListInside.contains(inside)) {
                boatListInside.add(inside);
              }
              //   break; // Stop checking other placemarks once a match is found
            }
          }
        }

        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 800,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...boatListInside.map(
                      (boatInside) => InkWell(
                        onTap: () async {
                          final boatListHolder =
                              ref.read(boatProviderChangeNotifier);
                          await boatListHolder.getElemenIndex(boatInside);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowInformationNew(),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.grey.shade800,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: boatInside.imageList.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              boatInside.imageList[index],
                                              width: 250,
                                              height: 200,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.radar),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(boatInside.boatName),
                                    Spacer(),
                                    // ...List.generate(
                                    //   boatInside.rating.toInt(),
                                    //   (index) => Icon(
                                    //     size: 15,
                                    //     Icons.star,
                                    //     color: Colors.yellow,
                                    //   ),
                                    // ),
                                    Row(
                                      children: [
                                        // Full stars
                                        ...List.generate(
                                          boatInside.rating
                                              .floor(), // Full stars based on the integer part of the rating
                                          (index) => Icon(
                                            size: 15,
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                        // Half star if there's a decimal part (e.g., 2.5)
                                        if (boatInside.rating -
                                                boatInside.rating.floor() >=
                                            0.5)
                                          Icon(
                                            size: 15,
                                            Icons.star_half,
                                            color: Colors.yellow,
                                          ),
                                        // Empty stars for the remaining
                                        ...List.generate(
                                          5 -
                                              boatInside.rating
                                                  .ceil(), // Remaining empty stars
                                          (index) => Icon(
                                            size: 15,
                                            Icons.star_border,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 10),
                                    Text(boatInside.rating.toString())
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.group),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text('To ${boatInside.guests} Guests')
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                        'From ${boatInside.minimumPrice.toString()} P/hour')
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  //here is the cluster function for second polygon.
  ClusterizedPlacemarkCollection _getClusterizedCollectionSecond({
    required List<PlacemarkMapObject> placemarks,
    required List<BoatModel> boatList,
  }) {
    return ClusterizedPlacemarkCollection(
      mapId: const MapObjectId('clusterized-2'),
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
                  await ClusterIconPainter(cluster.size).getClusterIconBytes(),
                ),
              ),
            ),
          ),
        );
      },
      onClusterTap: (self, cluster) async {
        // await controller.moveCamera(
        //   animation:
        //       const MapAnimation(type: MapAnimationType.linear, duration: 0.3),
        //   CameraUpdate.newCameraPosition(
        //     CameraPosition(
        //       target: cluster.placemarks.first.point,
        //       zoom: zoom + 1,
        //     ),
        //   ),
        // );
        List<BoatModel> boatListInside = [];
        for (var inside in boatList) {
          for (var placemark in cluster.placemarks) {
            if (inside.address.any((e) =>
                e.latitude == placemark.point.latitude &&
                e.longitude == placemark.point.longitude)) {
              if (!boatListInside.contains(inside)) {
                boatListInside.add(inside);
              }

              //   break; // Stop checking other placemarks once a match is found
            }
          }
        }
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 800,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...boatListInside.map(
                      (boatInside) => InkWell(
                        onTap: () async {
                          final boatListHolder =
                              ref.read(boatProviderChangeNotifier);
                          await boatListHolder.getElemenIndex(boatInside);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowInformationNew(),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.grey.shade800,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: boatInside.imageList.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              boatInside.imageList[index],
                                              width: 250,
                                              height: 200,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.radar),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(boatInside.boatName),
                                    Spacer(),
                                    // ...List.generate(
                                    //   boatInside.rating.toInt(),
                                    //   (index) => Icon(
                                    //     size: 15,
                                    //     Icons.star,
                                    //     color: Colors.yellow,
                                    //   ),
                                    // ),
                                    Row(
                                      children: [
                                        // Full stars
                                        ...List.generate(
                                          boatInside.rating
                                              .floor(), // Full stars based on the integer part of the rating
                                          (index) => Icon(
                                            size: 15,
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                        // Half star if there's a decimal part (e.g., 2.5)
                                        if (boatInside.rating -
                                                boatInside.rating.floor() >=
                                            0.5)
                                          Icon(
                                            size: 15,
                                            Icons.star_half,
                                            color: Colors.yellow,
                                          ),
                                        // Empty stars for the remaining
                                        ...List.generate(
                                          5 -
                                              boatInside.rating
                                                  .ceil(), // Remaining empty stars
                                          (index) => Icon(
                                            size: 15,
                                            Icons.star_border,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 10),
                                    Text(boatInside.rating.toString())
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.group),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text('To ${boatInside.guests} Guests')
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                        'From ${boatInside.minimumPrice.toString()} P/hour')
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
/// Contents of the modal window with information about the point on the map
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
