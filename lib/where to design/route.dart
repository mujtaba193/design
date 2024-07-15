import 'dart:math';

import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class DrivingRoute extends StatefulWidget {
  double startLong;
  double startLat;
  double endLong;
  double endLat;
  DrivingRoute(
      {super.key,
      required this.startLat,
      required this.startLong,
      required this.endLong,
      required this.endLat});
  @override
  DrivingRouteState createState() => DrivingRouteState();
}

class DrivingRouteState extends State<DrivingRoute> {
  late final List<MapObject> mapObjects = [
    startPlacemark,
    //  stopByPlacemark,
    endPlacemark
  ];

  //current location
  late PlacemarkMapObject startPlacemark;
  // final PlacemarkMapObject stopByPlacemark = PlacemarkMapObject(
  //   mapId: const MapObjectId('stop_by_placemark'),
  //   point: const Point(latitude: 45.0360, longitude: 38.9746),
  //   icon: PlacemarkIcon.single(PlacemarkIconStyle(
  //       image: BitmapDescriptor.fromAssetImage('asset/location.png'),
  //       scale: 0.3)),
  // );
  late PlacemarkMapObject endPlacemark;
  @override
  void initState() {
    startPlacemark = PlacemarkMapObject(
      mapId: const MapObjectId('start_placemark'),
      point: Point(latitude: widget.startLat, longitude: widget.startLong),
      icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage('asset/location.png'),
          scale: 0.3)),
    );
    endPlacemark = PlacemarkMapObject(
        mapId: const MapObjectId('end_placemark'),
        point: Point(latitude: widget.endLat, longitude: widget.endLong),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('asset/location.png'),
            scale: 0.3)));
    _requestRoutes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(child: YandexMap(mapObjects: mapObjects)),
          const SizedBox(height: 20),
          Expanded(
              child: SingleChildScrollView(
                  child: Column(children: [
            TextButton(
              onPressed: _requestRoutes,
              child: Text('Build route'),
            ),
          ])))
        ]);
  }

  Future<void> _requestRoutes() async {
    // print(
    //     'Points: ${startPlacemark.point},${stopByPlacemark.point},${endPlacemark.point}');

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
            initialAzimuth: 0, routesCount: 5, avoidTolls: true));

    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => _SessionPage(startPlacemark,
                endPlacemark, resultWithSession.$1, resultWithSession.$2)));
  }
}

class _SessionPage extends StatefulWidget {
  final Future<DrivingSessionResult> result;
  final DrivingSession session;
  final PlacemarkMapObject startPlacemark;
  final PlacemarkMapObject endPlacemark;

  const _SessionPage(
      this.startPlacemark, this.endPlacemark, this.session, this.result);

  @override
  _SessionState createState() => _SessionState();
}

class _SessionState extends State<_SessionPage> {
  late final List<MapObject> mapObjects = [
    widget.startPlacemark,
    widget.endPlacemark
  ];

  final List<DrivingSessionResult> results = [];
  bool _progress = true;

  @override
  void initState() {
    super.initState();

    _init();
  }

  @override
  void dispose() {
    super.dispose();

    _close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Driving ${widget.session.id}')),
        body: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        YandexMap(
                          mapObjects: mapObjects,
                          onMapCreated: (_controller) {
                            _controller.moveCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  zoom: 12,
                                  target: widget.startPlacemark.point,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(children: <Widget>[
                    SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            !_progress
                                ? Container()
                                : TextButton.icon(
                                    icon: const CircularProgressIndicator(),
                                    label: const Text('Cancel'),
                                    onPressed: _cancel)
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _getList(),
                              )),
                        ),
                      ],
                    ),
                  ])))
                ])));
  }

  List<Widget> _getList() {
    final list = <Widget>[];

    if (results.isEmpty) {
      list.add((const Text('Nothing found')));
    }

    for (var r in results) {
      list.add(Container(height: 20));

      r.routes!.asMap().forEach((i, route) {
        list.add(
            Text('Route $i: ${route.metadata.weight.timeWithTraffic.text}'));
      });

      list.add(Container(height: 20));
    }

    return list;
  }

  Future<void> _cancel() async {
    await widget.session.cancel();

    setState(() {
      _progress = false;
    });
  }

  Future<void> _close() async {
    await widget.session.close();
  }

  Future<void> _init() async {
    await _handleResult(await widget.result);
  }

  Future<void> _handleResult(DrivingSessionResult result) async {
    setState(() {
      _progress = false;
    });

    if (result.error != null) {
      print('Error: ${result.error}');
      return;
    }

    setState(() {
      results.add(result);
    });
    setState(() {
      result.routes!.asMap().forEach((i, route) {
        mapObjects.add(PolylineMapObject(
          mapId: MapObjectId('route_${i}_polyline'),
          polyline: route.geometry,
          strokeColor:
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
          strokeWidth: 3,
        ));
      });
    });
  }
}
