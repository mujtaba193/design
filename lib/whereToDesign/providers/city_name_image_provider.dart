import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/city_model.dart';

final cityNameImageProvider = Provider<CityNameImageProvider>((ref) {
  return CityNameImageProvider();
});

class CityNameImageProvider {
  List<City>? cityNameImageList;

  readJsondata() async {
    var jsonStr = await rootBundle.loadString('asset/city.json');

    // Decode the JSON string into a Map
    Map<String, dynamic> jsonData = json.decode(jsonStr);

    // Parse the JSON data into the CityList model
    // boatList = jsonData.map((json) => BoatModel.fromJson(json)).toList();
    // cityNameImageList = jsonData.map((json) => City.fromJson(json));
  }
}
