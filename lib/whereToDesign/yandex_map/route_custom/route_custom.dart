import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../map_provider/map_change_notifier_provider.dart';
import '../map_provider/map_provider.dart';

class RouteCustom extends ConsumerStatefulWidget {
  double? endLatitude;
  double? endLongitude;
  final YandexMapController controller;
  // List<SearchSessionResult> addressResults = [];
  RouteCustom({
    super.key,
    required this.endLatitude,
    required this.endLongitude,
    required this.controller,
    //  required this.addressResults,
  });

  @override
  ConsumerState<RouteCustom> createState() => _RouteCustomState();
}

class _RouteCustomState extends ConsumerState<RouteCustom> {
  //Function to show no route if there are no route.
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

  @override
  Widget build(BuildContext context) {
    final mapChangeNotiProvider = ref.watch(mapChangeNotifierProvider);
    final mapHolder = ref.watch(mapProvider);
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Text('${mapChangeNotiProvider.endLatitude}'),
          Text('${mapChangeNotiProvider.endLongitude}'),
          // Text(
          //     'Address: ${widget.addressResults.first.items!.first.toponymMetadata!.address.formattedAddress}'),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  // setState(() {});
                  await mapHolder.requestDrivingRoutes(
                    mapChangeNotiProvider.endLatitude!,
                    mapChangeNotiProvider.endLongitude!,
                  );

                  mapHolder.drivingMapObjects;

                  await mapChangeNotiProvider.controller!.moveCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        zoom: 10,
                        target: Point(
                            latitude: mapHolder.lat!,
                            longitude: mapHolder.long!),
                      ),
                    ),
                  );
                  Navigator.pop(context);
                },
                icon: Icon(Icons.directions_car),
              ),
              IconButton(
                onPressed: () async {
                  // setState(() {});
                  // await _initialEndPlacmark();
                  setState(() {});
                  await mapHolder
                      .requestBicycleRoutes(
                    mapChangeNotiProvider.endLatitude!,
                    mapChangeNotiProvider.endLongitude!,
                  )
                      .then((value) {
                    if (value.routes == null || value.routes!.isEmpty == true) {
                      _showMyDialogNoRoute();
                    } else {
                      Navigator.of(context).pop();
                    }
                  });
                  setState(() {
                    mapHolder.bicycleMapObjects;
                  });

                  await mapChangeNotiProvider.controller!.moveCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        zoom: 10,
                        target: Point(
                            latitude: mapHolder.lat!,
                            longitude: mapHolder.long!),
                      ),
                    ),
                  );

                  //Navigator.of(context).pop();
                },
                icon: Icon(Icons.directions_bike),
              ),
              IconButton(
                onPressed: () async {
                  // _requestPedestrianRoutes();
                  // setState(() {});
                  // await _initialEndPlacmark();
                  setState(() {});
                  await mapHolder
                      .requestPedestrianRoutes(
                    mapChangeNotiProvider.endLatitude!,
                    mapChangeNotiProvider.endLongitude!,
                  )
                      .then((value) {
                    if (value.routes == null || value.routes!.isEmpty == true) {
                      _showMyDialogNoRoute();
                    } else {
                      Navigator.of(context).pop();
                    }
                  });
                  setState(() {
                    mapHolder.pedestrianMapObjects;
                  });

                  await mapChangeNotiProvider.controller!.moveCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        zoom: 10,
                        target: Point(
                            latitude: mapHolder.lat!,
                            longitude: mapHolder.long!),
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.directions_walk),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
