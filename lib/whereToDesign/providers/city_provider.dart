import 'dart:convert';

import 'package:design/whereToDesign/models/city_list_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/events_model.dart';

final cityProvider = Provider<City>((ref) {
  return City();
});

class City {
  List<String> cityNameList = [];
  String? selectedCityName;
  CityList? cityList;
  List<Event>? cityEvents;
  String? slectedevent;
  readJsondata() async {
    var jsonStr = await rootBundle.loadString('asset/city.json');

    // Decode the JSON string into a Map
    final Map<String, dynamic> jsonData = json.decode(jsonStr);

    // Parse the JSON data into the CityList model
    cityList = CityList.fromJson(jsonData);
  }

  // function to get
  void getCity(cityName) {
    selectedCityName = cityName;
  }

  // function to get events
  void getEvents() {
    for (var varr in cityList!.cities) {
      if (selectedCityName == varr.cityName) {
        cityEvents = varr.events;
      }
    }
    // logic for gating city name
    // for (var varr in cityList!.cities) {
    //   cityEvents = varr.events;
    // }
  }

  // function to get selected event
  getSelectedEvent(element) {
    // cityEvents!.where((ele) => slectedevent == element.eventName);
    slectedevent = element.eventName;
  }
  // filter function
}
