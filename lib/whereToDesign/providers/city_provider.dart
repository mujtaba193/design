import 'dart:convert';

import 'package:design/whereToDesign/models/city_list_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cityProvider = Provider<City>((ref) {
  return City();
});

class City {
  List<String> cityNameList = [];

  CityList? cityList;
  List? cityEvents;
  readJsondata() async {
    var jsonStr = await rootBundle.loadString('asset/city.json');

    // Decode the JSON string into a Map
    final Map<String, dynamic> jsonData = json.decode(jsonStr);

    // Parse the JSON data into the CityList model
    cityList = CityList.fromJson(jsonData);
  }

  // function to get
  void getCity() {
    // logic for gating city name
    for (var varr in cityList!.cities) {
      String cityName = varr.cityName;
      cityEvents = varr.events;
      cityNameList.add(cityName);
    }
  }

  // function to get events
  void getEvents() {
    // logic for gating city name
    for (var varr in cityList!.cities) {
      cityEvents = varr.events;
    }
  }
  // filter function
}
