import 'package:design/where%20to%20design/users_model/address_model.dart';
import 'package:design/where%20to%20design/yandex_map.dart';
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
  late final GeoObject geoObject;

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
              onObjectTap: (geoObject) {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              //  Text('${geoObject.descriptionText}'),
                              Text('${geoObject.name}'),
                              Text('${geoObject.boundingBox}'),
                              Text(
                                geoObject.descriptionText,
                                style: TextStyle(color: Colors.red),
                              ),
                              Text(geoObject.selectionMetadata!.dataSourceName),
                              Text(geoObject.selectionMetadata!.layerId),
                              // ListView.builder(
                              //   itemCount: geoObject.aref.length,
                              //   itemBuilder: (context, index) {
                              //     return Text('${geoObject.aref[index]}');
                              //   },
                              // )
                            ],
                          ),
                        ),
                      );
                    });
              },
              onMapTap: (a) async {},
              nightModeEnabled: true,
              mapObjects: [
                _getClusterizedCollection(
                  placemarks: widget.address
                      .map(
                        (e) => PlacemarkMapObject(
                          // onTap: (mapObject, point) {
                          //   showModalBottomSheet(
                          //       context: context,
                          //       builder: (context) {
                          //         return Container(
                          //           height:
                          //               MediaQuery.of(context).size.height * 0.3,
                          //           width: MediaQuery.of(context).size.width,
                          //           child: Column(
                          //             children: [
                          //               Text('${e.username}'),
                          //               Text('${e.latitude}'),
                          //               Text('${e.longitude}'),
                          //             ],
                          //           ),
                          //         );
                          //       });
                          // },
                          icon: PlacemarkIcon.single(PlacemarkIconStyle(
                              //rotationType: RotationType.rotate,
                              isFlat: true,
                              scale: 0.2,
                              image: BitmapDescriptor.fromAssetImage(
                                  'asset/location.png'))),
                          mapId: MapObjectId(e.username),
                          point: Point(
                              latitude: e.latitude, longitude: e.longitude),
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
