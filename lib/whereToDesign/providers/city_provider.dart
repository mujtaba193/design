import 'dart:convert';

import 'package:design/whereToDesign/models/city_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/events_model.dart';

final cityProvider = ChangeNotifierProvider<City>((ref) {
  return City();
});

class City extends ChangeNotifier {
  List<String> cityNameList = [];
  String? selectedCityName;
  CityList? cityList;
  List<Event>? cityEvents;
  String? selectedevent;
  double? selectedeventMinHour;
  readJsondata() async {
    var jsonStr = await rootBundle.loadString('assets/city.json');

    // Decode the JSON string into a Map
    final Map<String, dynamic> jsonData = json.decode(jsonStr);

    // Parse the JSON data into the CityList model
    cityList = CityList.fromJson(jsonData);
    notifyListeners();
  }

  // function to get
  // void getCity(cityName) {
  //   selectedCityName = cityName;
  // }

  // function to get events
  void getEvents() {
    for (var varr in cityList!.cities) {
      if (selectedCityName == varr.cityName) {
        cityEvents = varr.events;
      }
    }
    notifyListeners();
  }

  // function to get selected event
  getSelectedEvent(Event element) {
    // cityEvents!.where((ele) => slectedevent == element.eventName);
    selectedevent = element.eventName;
    notifyListeners();
  }

  // function to get selected event
  getSelectedEventMinHours(Event element) {
    // cityEvents!.where((ele) => slectedevent == element.eventName);
    selectedeventMinHour = element.minHours;
    notifyListeners();
  }
  // filter function
}
