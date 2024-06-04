import 'package:design/where%20to%20design/users_model/address_model.dart';
import 'package:flutter/material.dart';
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
              onMapTap: (a) async {},
              nightModeEnabled: true,
              mapObjects: [
                ...widget.address
                    .map(
                      (e) => PlacemarkMapObject(
                        icon: PlacemarkIcon.single(PlacemarkIconStyle(
                            //rotationType: RotationType.rotate,
                            isFlat: true,
                            scale: 0.2,
                            image: BitmapDescriptor.fromAssetImage(
                                'asset/location.png'))),
                        mapId: MapObjectId(e.username),
                        point:
                            Point(latitude: e.latitude, longitude: e.longitude),
                        // text: PlacemarkText(
                        //   text: '${e.username}',
                        //   style: PlacemarkTextStyle(),
                        // ),
                      ),
                    )
                    .toList(),
              ],
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
          Positioned(
              top: 400,
              right: 5,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFFFAFAFA).withOpacity(0.6),
                    ),
                    width: 40,
                    height: 40,
                    child: IconButton(
                      onPressed: () {
                        zoom = zoom + 2;

                        controller.moveCamera(
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
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFFFAFAFA).withOpacity(0.6),
                    ),
                    width: 40,
                    height: 40,
                    child: IconButton(
                      onPressed: () {
                        zoom = zoom - 2;

                        controller.moveCamera(
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
                      icon: Icon(
                        Icons.remove,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
