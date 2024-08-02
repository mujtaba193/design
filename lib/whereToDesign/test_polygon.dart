import 'dart:math';

import 'package:design/whereToDesign/users_model/address_model.dart';
import 'package:design/whereToDesign/yandex_map.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapPage extends StatefulWidget {
  List<AddressModel> address;
  MapPage({super.key, required this.address});
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // late YandexMapController controller;
  late final YandexMapController controller;
  double zoom = 15.0;
  late final GeoObject geoObject;
  bool _drawPolygonEnabled = false;
  List<Point> _userPolyLinesLatLngList = [];

  bool _clearDrawing = false;
  double? _lastXCoordinate, _lastYCoordinate;
  final MapObjectId mapObjectId = const MapObjectId('polyline');
  final List<MapObject> mapObjects = [];
  late List<AddressModel> insidePolygon = [];
  LineObject? line;
  late PlacemarkMapObject currentLocationPlacemark;
  double? lat;
  double? long;
  double? endLatitude;
  double? endLongitude;
  MapType mapType = MapType.vector;
  late PlacemarkMapObject endPlacemark;
  late PlacemarkMapObject startPlacemark;
  List<AddressModel> newaddressInside = [];
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
        // if (line != null) {
        //   //line!.last.add(details.localPosition);
        //   line;
        // }
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

//////
  void _onPanStart(DragStartDetails details) {
    setState(() {
      line = LineObject(points: [details.localPosition]);
      // if (line != null) {
      //   line!.points.add(details.localPosition);
      // }
    });
  }
  //////

  _clearPolygons() {
    setState(() {
      _userPolyLinesLatLngList.clear();
      mapObjects.clear();
      newaddressInside.clear();
      // lines.clear();
      // lines.last.points.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yandex Map with Polygon'),
      ),
      body: GestureDetector(
        onPanUpdate: (_drawPolygonEnabled) ? _onPanUpdate : null,
        onPanStart: _onPanStart,
        onPanEnd: (_drawPolygonEnabled) ? _onPanEnd : null,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18.0),
              child: YandexMap(
                mapType: mapType,
                onMapTap: (argument) {
                  setState(
                    () {
                      endLatitude = argument.latitude;
                      endLongitude = argument.longitude;
                    },
                  );
                },
                nightModeEnabled: true,
                mapObjects: (_drawPolygonEnabled)
                    ? [
                        ...mapObjects,
                        _getClusterizedCollection(
                          placemarks: newaddressInside
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
                  //
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
      // YandexMap(
      //   onMapCreated: (YandexMapController controller) {
      //     _controller = controller;
      //   },
      // ),
    );
  }

///////////////////////////////////////////////////////////////////////////////////
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

  // void _checkPoint() {
  //   Point testPoint = Point(latitude: 55.745, longitude: 37.623);
  //   List<Point> polygon = [
  //     Point(latitude: 55.751244, longitude: 37.618423),
  //     Point(latitude: 55.751744, longitude: 37.628423),
  //     Point(latitude: 55.741244, longitude: 37.628423),
  //     Point(latitude: 55.741244, longitude: 37.618423),
  //   ];
  //   bool inside = isPointInPolygon(testPoint, polygon);
  //   print('Point is ${inside ? "inside" : "outside"} the polygon.');
  // }
}

// class LineObject {
//   final List<Offset> points;
//   final Color color;
//   final double strokeWidth;

//   const LineObject({
//     required this.points,
//     this.color = Colors.red,
//     this.strokeWidth = 20.0,
//   });

//   LineObject copyWith({
//     List<Offset>? points,
//     Color? color,
//     double? strokeWidth,
//   }) {
//     return LineObject(
//       points: points ?? this.points,
//       color: color ?? this.color,
//       strokeWidth: strokeWidth ?? this.strokeWidth,
//     );
//   }
// }

// //////////////////
// class FingerPainter extends CustomPainter {
//   final LineObject line;
//   const FingerPainter({
//     required this.line,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..color = line.color
//       ..strokeWidth = line.strokeWidth
//       ..strokeCap = StrokeCap.round;

//     for (var i = 0; i < line.points.length - 1; i++) {
//       canvas.drawLine(line.points[i], line.points[i + 1], paint);
//     }
//   }

//   @override
//   bool shouldRepaint(FingerPainter oldDelegate) => true;
// }

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
