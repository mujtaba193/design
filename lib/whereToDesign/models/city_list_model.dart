import 'dart:convert';

import 'package:design/whereToDesign/models/city_model.dart';

// Main model class to represent the whole JSON structure
class CityList {
  final List<City> cities;

  CityList({required this.cities});

  factory CityList.fromJson(Map<String, dynamic> json) {
    var cityList = json['city'] as List;
    List<City> cityObjs =
        cityList.map((cityJson) => City.fromJson(cityJson)).toList();

    return CityList(
      cities: cityObjs,
    );
  }
}

// Function to parse JSON string
CityList parseCities(String jsonString) {
  final Map<String, dynamic> jsonData = json.decode(jsonString);
  return CityList.fromJson(jsonData);
}
