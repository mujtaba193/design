import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class YandexMapsCustom extends StatefulWidget {
  final Future<DrivingSessionResult>? result;
  final DrivingSession? session;
  final Future<BicycleSessionResult>? bicResult;
  final BicycleSession? bicSession;
  final Future<PedestrianSessionResult>? pedResult;
  final PedestrianSession? pedSession;
  final PlacemarkMapObject startPlacemark;
  final PlacemarkMapObject endPlacemark;
  final List<DrivingSessionResult>? results;
  final List<BicycleSessionResult>? bicResults;
  final List<PedestrianSessionResult>? pedResults;
  final List<MapObject> mapObjects;
  const YandexMapsCustom(
      {super.key,
      required this.startPlacemark,
      required this.endPlacemark,
      this.session,
      this.result,
      this.results,
      this.bicResults,
      this.bicResult,
      this.bicSession,
      this.pedSession,
      this.pedResult,
      this.pedResults,
      required this.mapObjects});

  @override
  State<YandexMapsCustom> createState() => _YandexMapsCustomState();
}

class _YandexMapsCustomState extends State<YandexMapsCustom> {
  late final YandexMapController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: YandexMap(
            nightModeEnabled: true,
            mapObjects: widget.mapObjects,
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
                                latitude: widget.startPlacemark.point.latitude,
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
    );
  }
}
