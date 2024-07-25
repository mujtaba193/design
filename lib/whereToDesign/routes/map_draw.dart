import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapDraw extends StatefulWidget {
  final List<MapObject> mapObjects;
  final PlacemarkMapObject endPlacemark;
  final MapObjectId? mapObjectId;
  const MapDraw(
      {super.key,
      required this.mapObjects,
      required this.endPlacemark,
      this.mapObjectId});

  @override
  State<MapDraw> createState() => _MapDrawState();
}

class _MapDrawState extends State<MapDraw> {
  late final YandexMapController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () async {
                setState(() {
                  widget.mapObjects
                      .removeWhere((el) => el.mapId == widget.mapObjectId);
                });
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back))
        ],
      ),
      body: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: YandexMap(
            nightModeEnabled: true,
            mapObjects: widget.mapObjects,
            onMapCreated: (_controller) {
              controller = _controller;
              _controller.moveCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    zoom: 10,
                    target: widget.endPlacemark.point,
                  ),
                ),
              );
            },
          )
          // YandexMap(
          //   nightModeEnabled: true,
          //   mapObjects: widget.mapObjects,
          //   onMapCreated: (_controller) {
          //     controller = _controller;
          //     _controller.moveCamera(
          //       CameraUpdate.newCameraPosition(
          //         CameraPosition(
          //           zoom: 12,
          //           target: widget.startPlacemark.point,
          //         ),
          //       ),
          //     );
          //   },
          // ),
          ),
    );
  }
}
