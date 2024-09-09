import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

final mapProvider = Provider<MapProviderClass>(
  (ref) {
    return MapProviderClass();
  },
);

class MapProviderClass {
  late Future<DrivingSessionResult> drivingResult;
  final List<DrivingSessionResult> drivingResults = [];
  late DrivingSession drivingSession;
  late List<MapObject> drivingMapObjects = [];
  late List<MapObject> bicycleMapObjects = [];
  late List<MapObject> pedestrianMapObjects = [];

  late PlacemarkMapObject initEndPlacemark;
  late PlacemarkMapObject initstartPlacemark;
  late bool servicesEnabled;
  late PermissionStatus permission;
  double? lat;
  double? long;
  final List<SearchSessionResult> addressResults = [];

////////*********************************************************////////////
  // Future<void> _initRealAddress() async {
  //   final cameraPosition = await controller.getCameraPosition();

  //   final resultWithSession = await YandexSearch.searchByPoint(
  //     point: cameraPosition.target,
  //     zoom: cameraPosition.zoom.toInt(),
  //     searchOptions: const SearchOptions(
  //       searchType: SearchType.geo,
  //       geometry: false,
  //     ),
  //   );
  //   await _handleResultRealAddress(
  //       await resultWithSession.$2, resultWithSession.$1);
  // }

  // Future<void> _handleResultRealAddress(
  //     SearchSessionResult result, SearchSession session) async {
  //   setState(() {
  //     _progress = false;
  //   });

  //   if (result.error != null) {
  //     print('Error: ${result.error}');
  //     return;
  //   }

  //   print('Page ${result.page}: $result');

  //   setState(() {
  //     addressResults.add(result);
  //   });
  // }

/////////////////////////////////////////
  /// Function to get current location
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

    lat = locationData.latitude!;
    long = locationData.longitude!;
    // await _initialEndPlacmark();

    return locationData;
  }

/////////////////////////////////////////
  Future initialEndPlacmark(
    double endLatitude,
    double endLongitude,
  ) async {
    initEndPlacemark = PlacemarkMapObject(
      mapId: const MapObjectId('end_placemark'),
      point: Point(latitude: endLatitude, longitude: endLongitude),
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('asset/flagYallow.png'),
            scale: 0.6),
      ),
    );
  }

  Future initialStartPlacmark() async {
    await getCurrentLucation();
    initstartPlacemark = PlacemarkMapObject(
      mapId: const MapObjectId('start_placemark'),
      point: Point(latitude: lat!, longitude: long!),
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('asset/399308.png'),
            scale: 0.2),
      ),
    );
  }

////////////////////////////////////////////// Driving section ////////////////////////////////////////////////
  //Driving handleResult
  Future<void> drivingHandleResult(
      DrivingSessionResult result, List<MapObject> drivingMapObjects) async {
    if (result.error != null) {
      print('Error: ${result.error}');
    }
    // drivingResults.add(result);
    result.routes!.asMap().forEach(
      (i, route) {
        drivingMapObjects.add(
          PolylineMapObject(
            mapId: MapObjectId('route_${i}_polyline'),
            polyline: route.geometry,
            strokeColor: Colors.red,
            strokeWidth: 3,
          ),
        );
      },
    );
  }

  //Driving function
  Future requestDrivingRoutes(
    double endLatitude,
    double endLongitude,
  ) async {
    // drivingMapObjects.clear();
    // call the function initialEndPlacmark to initial endPlacemark.
    initialEndPlacmark(endLatitude, endLongitude);

    // call the function initialStartPlacmark to initial startPlacemark.
    await initialStartPlacmark();

    drivingMapObjects = [initstartPlacemark, initEndPlacemark];

    var resultWithSession = await YandexDriving.requestRoutes(
      points: [
        RequestPoint(
            point: initstartPlacemark.point,
            requestPointType: RequestPointType.wayPoint),
        RequestPoint(
            point: initEndPlacemark.point,
            requestPointType: RequestPointType.wayPoint),
      ],
      drivingOptions: const DrivingOptions(
          initialAzimuth: 0, routesCount: 1, avoidTolls: true),
    );

    await drivingHandleResult(await resultWithSession.$2, drivingMapObjects);
  }

  ///////////////////////////////////////////////// bicycle section //////////////////////////////////////////////////////
  /// //Bicycles handleResult
  Future<BicycleSessionResult> bicycleHandleResult(
      BicycleSessionResult result, List<MapObject> bicycleMapObjects) async {
    if (result.error != null) {
      print('Error: ${result.error}');

      return result;
    }

    // result.routes!.asMap().forEach((i, route) {
    //   bicycleMapObjects.add(PolylineMapObject(
    //     mapId: MapObjectId('route_${i}_polyline'),
    //     polyline: route.geometry,
    //     strokeColor:
    //         Colors.primaries[Random().nextInt(Colors.primaries.length)],
    //     strokeWidth: 3,
    //   ));
    // });
    if (result.routes != null && result.routes!.isNotEmpty) {
      final fastestRoute = result.routes!.first;

      bicycleMapObjects.add(PolylineMapObject(
        mapId: MapObjectId('fastest_route_polyline'),
        polyline: fastestRoute.geometry,
        strokeColor: Colors.green.shade600,
        strokeWidth: 3,
      ));
    }

    try {
      result;
    } catch (e) {
      print('object');
    }
    return result;
  }

// Bicycle function
  Future<BicycleSessionResult> requestBicycleRoutes(
    double endLatitude,
    double endLongitude,
  ) async {
    // call the function initialEndPlacmark to initial endPlacemark.
    initialEndPlacmark(endLatitude, endLongitude);
    // call the function initialStartPlacmark to initial startPlacemark.
    // initialStartPlacmark(lat!, long!);
    bicycleMapObjects = [initstartPlacemark, initEndPlacemark];

    var resultWithSession = await YandexBicycle.requestRoutes(
      points: [
        RequestPoint(
            point: initstartPlacemark.point,
            requestPointType: RequestPointType.wayPoint),
        RequestPoint(
            point: initEndPlacemark.point,
            requestPointType: RequestPointType.wayPoint),
      ],
      bicycleVehicleType: BicycleVehicleType.bicycle,
    );
    await bicycleHandleResult(await resultWithSession.$2, bicycleMapObjects)
        .then((value) => value);
    try {
      resultWithSession;
    } catch (e) {
      print('object');
    }
    return resultWithSession.$2;
  }

  ///////////////////////////////////////////////// Pedestrian section ////////////////////////////////////////////

  /////Pedestrian handleResult
  Future<PedestrianSessionResult> pedestrianHandleResult(
      PedestrianSessionResult result,
      List<MapObject> pedestrianMapObjects) async {
    if (result.error != null) {
      print('Error: ${result.error}');
      return result;
    }

    if (result.routes != null && result.routes!.isNotEmpty) {
      final fastestRoute = result.routes!.first;

      pedestrianMapObjects.add(PolylineMapObject(
        mapId: MapObjectId('fastest_route_polyline'),
        polyline: fastestRoute.geometry,
        strokeColor: Colors.yellow,
        strokeWidth: 3,
      ));
    }
    // result.routes!.asMap().forEach((i, route) {
    //   pedestrianMapObjects.add(PolylineMapObject(
    //     mapId: MapObjectId('route_${i}_polyline'),
    //     polyline: route.geometry,
    //     strokeColor:
    //         Colors.primaries[Random().nextInt(Colors.primaries.length)],
    //     strokeWidth: 3,
    //   ));
    // });
    try {
      result;
    } catch (e) {
      print('object');
    }
    return result;
  }

  Future<PedestrianSessionResult> requestPedestrianRoutes(
    double endLatitude,
    double endLongitude,
  ) async {
    // call the function initialEndPlacmark to initial endPlacemark.
    initialEndPlacmark(endLatitude, endLongitude);
    // call the function initialStartPlacmark to initial startPlacemark.
    // initialStartPlacmark(lat!, long!);

    pedestrianMapObjects = [initstartPlacemark, initEndPlacemark];
    var resultWithSession = await YandexPedestrian.requestRoutes(
      timeOptions: TimeOptions(departureTime: DateTime.now()),
      avoidSteep: true,
      points: [
        RequestPoint(
            point: initstartPlacemark.point,
            requestPointType: RequestPointType.wayPoint),
        // RequestPoint(
        //     point: stopByPlacemark.point,
        //     requestPointType: RequestPointType.viaPoint),
        RequestPoint(
            point: initEndPlacemark.point,
            requestPointType: RequestPointType.wayPoint),
      ],
    );
    await pedestrianHandleResult(
            await resultWithSession.$2, pedestrianMapObjects)
        .then((value) => value);
    try {
      resultWithSession;
    } catch (e) {
      print('object');
    }
    return resultWithSession.$2;
  }
}
