import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

final mapChangeNotifierProvider = ChangeNotifierProvider<MapElements>((ref) {
  return MapElements();
});

class MapElements extends ChangeNotifier {
  // MapElements () {}

  double? endLatitude;
  double? endLongitude;
  YandexMapController? controller;
  // List<SearchSessionResult> addressResults = [];
  Future givValues(
    endLatitudeIn,
    endLongitudeIn,
    controllerIn,
    // addressResultsIn,
  ) async {
    endLatitude = endLatitudeIn;
    endLongitude = endLongitudeIn;
    controller = controllerIn;
    // addressResults.addAll(addressResultsIn);
    notifyListeners();
  }
}
