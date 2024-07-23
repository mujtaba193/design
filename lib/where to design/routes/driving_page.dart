import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class SessionPage extends StatefulWidget {
  final Future<DrivingSessionResult> result;
  final DrivingSession session;
  final PlacemarkMapObject startPlacemark;
  final PlacemarkMapObject endPlacemark;

  const SessionPage(
      this.startPlacemark, this.endPlacemark, this.session, this.result);

  @override
  _SessionState createState() => _SessionState();
}

class _SessionState extends State<SessionPage> {
  late final List<MapObject> mapObjects = [
    widget.startPlacemark,
    widget.endPlacemark
  ];
  late final YandexMapController controller;
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

    //_close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Driving route')),
      body: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: YandexMap(
              nightModeEnabled: true,
              mapObjects: mapObjects,
              onMapCreated: (_controller) {
                controller = _controller;
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
                      if (widget.startPlacemark.point.latitude != null) {
                        await controller.moveCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              zoom: 10,
                              target: Point(
                                  latitude:
                                      widget.startPlacemark.point.latitude,
                                  longitude:
                                      widget.startPlacemark.point.longitude),
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
            ),
          )
        ],
      ),
    );
  }

  // List<Widget> _getList() {
  //   final list = <Widget>[];

  //   if (results.isEmpty) {
  //     list.add((const Text('Nothing found')));
  //   }

  //   for (var r in results) {
  //     r.routes!.asMap().forEach((i, route) {
  //       list.add(
  //         Text(
  //           'Route $i: ${route.metadata.weight.timeWithTraffic.text}',
  //         ),
  //       );
  //     });
  //   }

  //   return list;
  // }

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
    setState(
      () {
        result.routes!.asMap().forEach(
          (i, route) {
            mapObjects.add(
              PolylineMapObject(
                mapId: MapObjectId('route_${i}_polyline'),
                polyline: route.geometry,
                strokeColor: Colors.red,
                strokeWidth: 3,
              ),
            );
          },
        );
      },
    );
  }
}
