import 'dart:typed_data';
import 'dart:ui';

import 'package:design/where%20to%20design/users_model/address_model.dart';
import 'package:design/where%20to%20design/yandex_map.dart';
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
  double? longt;
  MapType mapType = MapType.vector;

  DrivingSessionResult? _drivingResultWithSession;

  /// Список точек на карте, по которым строится автомобильный маршрут
  List<Point> _drivingPointsList = [];
  List<PolylineMapObject> _drivingMapLines = [];
  List<Point>? _polygonPointsList;

  @override
  void initState() {
    getCurrentLucation();
    lat;
    longt;
    super.initState();
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

    setState(() {
      lat = locationData.latitude!;
      longt = locationData.longitude!;
    });
    return locationData;
  }

  /// Метод для генерации точек начала и конца маршрута
  List<PlacemarkMapObject> _getDrivingPlacemarks(
    BuildContext context, {
    required List<Point> drivingPoints,
  }) {
    return drivingPoints
        .map(
          (point) => PlacemarkMapObject(
            mapId: MapObjectId('MapObject $point'),
            point: Point(latitude: point.latitude, longitude: point.longitude),
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(
                  'assets/icons/car_point.png',
                ),
                scale: 2,
              ),
            ),
          ),
        )
        .toList();
  }

  /// Метод для получения маршрутов проезда от точки начала к точке конца
  Future<(DrivingSession, Future<DrivingSessionResult>)>
      _getDrivingResultWithSession({
    required Point startPoint,
    required Point endPoint,
  }) {
    var drivingResultWithSession = YandexDriving.requestRoutes(
      points: [
        RequestPoint(
          point: startPoint,
          requestPointType: RequestPointType.wayPoint, // точка начала маршрута
        ),
        RequestPoint(
          point: endPoint,
          requestPointType: RequestPointType.wayPoint, // точка конца маршрута
        ),
      ],
      drivingOptions: const DrivingOptions(
        initialAzimuth: 0,
        routesCount: 5,
        avoidTolls: true,
        avoidPoorConditions: true,
      ),
    );

    return drivingResultWithSession;
  }

  Future<void> _buildRoutes() async {
    final drivingResult = await _drivingResultWithSession;

    setState(() {
      for (var element in drivingResult?.routes ?? []) {
        _drivingMapLines.add(
          PolylineMapObject(
            mapId: MapObjectId('route $element'),
            polyline: Polyline(points: element.geometry),
            strokeColor:
                // генерируем случайный цвет для каждого маршрута
                Colors.red,
            strokeWidth: 3,
          ),
        );
      }
    });
  }

  /// Метод для генерации точек на карте
  List<MapPoint> _getMapPoints() {
    return const [
      MapPoint(name: 'Москва', latitude: 55.755864, longitude: 37.617698),
      MapPoint(name: 'Лондон', latitude: 51.507351, longitude: -0.127696),
      MapPoint(name: 'Рим', latitude: 41.887064, longitude: 12.504809),
      MapPoint(name: 'Париж', latitude: 48.856663, longitude: 2.351556),
      MapPoint(name: 'Стокгольм', latitude: 59.347360, longitude: 18.341573),
    ];
  }

  /// Метод для генерации объектов маркеров для отображения на карте
  List<PlacemarkMapObject> _getPlacemarkObjects(BuildContext context) {
    return _getMapPoints()
        .map(
          (point) => PlacemarkMapObject(
            mapId: MapObjectId('MapObject $point'),
            point: Point(latitude: point.latitude, longitude: point.longitude),
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(
                  'assets/icons/map_point.png',
                ),
                scale: 2,
              ),
            ),
            onTap: (_, __) => showModalBottomSheet(
              context: context,
              builder: (context) => _ModalBodyView(
                point: point,
              ),
            ),
          ),
        )
        .toList();
  }

  /// Метод для генерации объекта выделенной зоны на карте
  PolygonMapObject _getPolygonMapObject(
    BuildContext context, {
    required List<Point> points,
  }) {
    return PolygonMapObject(
      mapId: const MapObjectId('polygon map object'),
      polygon: Polygon(
        // внешняя линия зоны
        outerRing: LinearRing(
          points: points,
        ),
        // внутренняя линия зоны, которая формирует пропуски в полигоне
        innerRings: const [],
      ),
      strokeColor: Colors.blue,
      strokeWidth: 3.0,
      fillColor: Colors.blue.withOpacity(0.2),
      onTap: (_, point) => showModalBottomSheet(
        context: context,
        builder: (context) => _ModalBodyView(
          point: MapPoint(
            name: 'Неизвестный населенный пункт',
            latitude: point.latitude,
            longitude: point.longitude,
          ),
        ),
      ),
    );
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
            child: YandexMap(
              mapType: mapType,
              // onObjectTap: (geoObject) {
              //   showModalBottomSheet(
              //       context: context,
              //       builder: (context) {
              //         return Container(
              //           height: MediaQuery.of(context).size.height * 0.3,
              //           width: MediaQuery.of(context).size.width,
              //           child: SingleChildScrollView(
              //             child: Column(
              //               children: [
              //                 //  Text('${geoObject.descriptionText}'),
              //                 Text('${geoObject.name}'),
              //                 Text('${geoObject.boundingBox}'),
              //                 Text(
              //                   geoObject.descriptionText,
              //                   style: TextStyle(color: Colors.red),
              //                 ),
              //                 Text(geoObject.selectionMetadata!.dataSourceName),
              //                 Text(geoObject.selectionMetadata!.layerId),
              //                 // ListView.builder(
              //                 //   itemCount: geoObject.aref.length,
              //                 //   itemBuilder: (context, index) {
              //                 //     return Text('${geoObject.aref[index]}');
              //                 //   },
              //                 // )
              //               ],
              //             ),
              //           ),
              //         );
              //       });
              // },
              // onMapLongTap: (argument) {
              //   setState(() {
              //     // добавляем точку маршрута на карте, если еще не выбраны две точки
              //     if (_drivingPointsList.length < 2) {
              //       _drivingPointsList.add(argument);
              //     } else {
              //       _drivingPointsList = [];
              //       _drivingMapLines = [];
              //       _drivingResultWithSession = null;
              //     }

              //     // когда выбраны точки начала и конца,
              //     // получаем данные предложенных маршрутов
              //     if (_drivingPointsList.length == 2) {
              //       _drivingResultWithSession = _getDrivingResultWithSession(
              //         startPoint: _drivingPointsList.first,
              //         endPoint: _drivingPointsList.last,
              //       );
              //     }
              //   });

              //   _buildRoutes();
              // },
              mapObjects: [
                _getClusterizedCollection(
                  placemarks: _getPlacemarkObjects(context),
                ),
                _getPolygonMapObject(context, points: _polygonPointsList ?? []),
                ..._getDrivingPlacemarks(context,
                    drivingPoints: _drivingPointsList),
                ..._drivingMapLines,
              ],
              onMapTap: (argument) {
                setState(() {
                  // добавляем точку маршрута на карте, если еще не выбраны две точки
                  if (_drivingPointsList.length < 2) {
                    _drivingPointsList.add(argument);
                  } else {
                    _drivingPointsList = [];
                    _drivingMapLines = [];
                    _drivingResultWithSession = null;
                  }

                  // когда выбраны точки начала и конца,
                  // получаем данные предложенных маршрутов
                  if (_drivingPointsList.length == 2) {
                    _drivingResultWithSession = _getDrivingResultWithSession(
                      startPoint: _drivingPointsList.first,
                      endPoint: _drivingPointsList.last,
                    ) as DrivingSessionResult?;
                  }
                });

                _buildRoutes();
              },
              nightModeEnabled: true,
              // mapObjects: [
              //   _getClusterizedCollection(
              //     placemarks: widget.address
              //         .map(
              //           (e) => PlacemarkMapObject(
              //             onTap: (mapObject, point) {
              //               showModalBottomSheet(
              //                   context: context,
              //                   builder: (context) {
              //                     return Container(
              //                       height: MediaQuery.of(context).size.height *
              //                           0.3,
              //                       width: MediaQuery.of(context).size.width,
              //                       child: Column(
              //                         children: [
              //                           Text('${e.username}'),
              //                           Text('${e.latitude}'),
              //                           Text('${e.longitude}'),
              //                         ],
              //                       ),
              //                     );
              //                   });
              //             },
              //             icon: PlacemarkIcon.single(PlacemarkIconStyle(
              //                 //rotationType: RotationType.rotate,
              //                 isFlat: true,
              //                 scale: 0.2,
              //                 image: BitmapDescriptor.fromAssetImage(
              //                     'asset/location.png'))),
              //             mapId: MapObjectId(e.username),
              //             point: Point(
              //                 latitude: e.latitude, longitude: e.longitude),
              //             // text: PlacemarkText(
              //             //   text: '${e.username}',
              //             //   style: PlacemarkTextStyle(),
              //             // ),
              //             consumeTapEvents: true,
              //             opacity: 3,
              //           ),
              //         )
              //         .toList(),
              //   ),
              // ],
              onMapCreated: (_controller) {
                controller = _controller;
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
                                zoom: 3,
                                target:
                                    Point(latitude: lat!, longitude: longt!),
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
                  )
                ],
              ))
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
