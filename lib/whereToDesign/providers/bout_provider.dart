import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/boat_model.dart';
import '../translation/filter_translation.dart';

final boutProvider = Provider<Boat>((ref) {
  return Boat();
});

class Boat with ChangeNotifier {
  List<BoatModel> boatList = [];
  ///////////filter variables //////////////////
  double startPrice = 1;
  double endPrice = 10000;
  double startLength = 1;
  double endLength = 10000;
  double startRating = 1;
  double endRating = 5;
  int? shipType;
  int? toilet;
  bool? rainValue;
  bool? bimini;
  bool? bluetooth;
  bool? mask;
  bool? shower;
  bool? fridge;
  bool? blankets;
  bool? table;
  bool? glasses;
  bool? bathing;
  bool? fishEcho;
  bool? heater;
  bool? climate;

  List<String> list = [
    FilterPageTranslation.highspeed,
    FilterPageTranslation.american,
    FilterPageTranslation.slowMoving,
    FilterPageTranslation.retro,
    FilterPageTranslation.closed,
    FilterPageTranslation.withFlybridge,
    FilterPageTranslation.withPanoramicWindows
  ];
  List<BoatModel> boatList1 = [];
  List<String> selectedlist = [];
  List<BoatModel>? filterList;
  String? theShipTypeValue;
  String? theToiletValue;
  bool filterValue = false;
  bool searchValue = false;
  String? selectedCityV;

  /// List<BoatModel>? searchFilterList;
  // with notifier ......................................................//
  List<BoatModel>? get filterListNotifier => filterList!.toList();
  readJsondata() async {
    var jsonStr = await rootBundle.loadString('assets/images_list.json');

    List<dynamic> jsonData = jsonDecode(jsonStr);

    boatList = jsonData.map((json) => BoatModel.fromJson(json)).toList();
  }

//function for filtering.
  filter() async {
    if (filterList == null || filterList!.isEmpty == true) {
      await readJsondata();
    }

    boatList1 = (filterList == null || filterList!.isEmpty == true)
        ? boatList
        : filterList!;
    filterList = boatList1
        .where((element) =>
            (element.finalPrice >= startPrice &&
                element.finalPrice <= endPrice) &&
            (element.characteristics.length >= startLength &&
                element.characteristics.length <= endLength) &&
            (element.rating >= startRating && element.rating <= endRating) &&
            (shipType == null || element.shipType == theShipTypeValue) &&
            (toilet == null || element.toiletOnBoard == theToiletValue) &&
            (rainValue != null
                ? element.characteristics.rain_awning == rainValue
                : true) &&
            (bimini != null
                ? element.characteristics.bimini_sunshade == bimini
                : true) &&
            (bluetooth != null
                ? element.characteristics.bluetooth_audio_system == bluetooth
                : true) &&
            (mask != null
                ? element.characteristics.snorkeling_mask == mask
                : true) &&
            (shower != null
                ? element.characteristics.shower == shower
                : true) &&
            (fridge != null
                ? element.characteristics.fridge == fridge
                : true) &&
            (blankets != null
                ? element.characteristics.blankets == blankets
                : true) &&
            (table != null ? element.characteristics.table == table : true) &&
            (glasses != null
                ? element.characteristics.glasses == glasses
                : true) &&
            (bathing != null
                ? element.characteristics.bathing_platform == bathing
                : true) &&
            (fishEcho != null
                ? element.characteristics.fish_echo_sounder == fishEcho
                : true) &&
            (heater != null
                ? element.characteristics.heater == heater
                : true) &&
            (climate != null
                ? element.characteristics.climate_control == climate
                : true) &&
            (selectedlist.contains(FilterPageTranslation.highspeed)
                ? element.features.highSpeed ==
                    selectedlist.contains(FilterPageTranslation.highspeed)
                : true) &&
            (selectedlist.contains(FilterPageTranslation.american)
                ? element.features.american ==
                    selectedlist.contains(FilterPageTranslation.american)
                : true) &&
            (selectedlist.contains(FilterPageTranslation.slowMoving)
                ? element.features.slowMoving ==
                    selectedlist.contains(FilterPageTranslation.slowMoving)
                : true) &&
            (selectedlist.contains(FilterPageTranslation.retro)
                ? element.features.retro ==
                    selectedlist.contains(FilterPageTranslation.retro)
                : true) &&
            (selectedlist.contains(FilterPageTranslation.closed)
                ? element.features.closed ==
                    selectedlist.contains(FilterPageTranslation.closed)
                : true) &&
            (selectedlist.contains(FilterPageTranslation.withFlybridge)
                ? element.features.withFlybridge ==
                    selectedlist.contains(FilterPageTranslation.withFlybridge)
                : true) &&
            (selectedlist.contains(FilterPageTranslation.withPanoramicWindows)
                ? element.features.withPanoramicWindows ==
                    selectedlist
                        .contains(FilterPageTranslation.withPanoramicWindows)
                : true))
        .toList();
    notifyListeners();
  }
  // filter() {
  //   filterList = boatList!
  //       .where((element) =>
  //           (element.finalPrice >= startPrice &&
  //               element.finalPrice <= endPrice) &&
  //           (element.characteristics.length >= startLength &&
  //               element.characteristics.length <= endLength) &&
  //           (element.rating >= startRating && element.rating <= endRating) &&
  //           (shipType == null || element.shipType == theShipTypeValue) &&
  //           (toilet == null || element.toiletOnBoard == theToiletValue) &&
  //           (rainValue != null
  //               ? element.characteristics.rain_awning == rainValue
  //               : true) &&
  //           (bimini != null
  //               ? element.characteristics.bimini_sunshade == bimini
  //               : true) &&
  //           (bluetooth != null
  //               ? element.characteristics.bluetooth_audio_system == bluetooth
  //               : true) &&
  //           (mask != null
  //               ? element.characteristics.snorkeling_mask == mask
  //               : true) &&
  //           (shower != null
  //               ? element.characteristics.shower == shower
  //               : true) &&
  //           (fridge != null
  //               ? element.characteristics.fridge == fridge
  //               : true) &&
  //           (blankets != null
  //               ? element.characteristics.blankets == blankets
  //               : true) &&
  //           (table != null ? element.characteristics.table == table : true) &&
  //           (glasses != null
  //               ? element.characteristics.glasses == glasses
  //               : true) &&
  //           (bathing != null
  //               ? element.characteristics.bathing_platform == bathing
  //               : true) &&
  //           (fishEcho != null
  //               ? element.characteristics.fish_echo_sounder == fishEcho
  //               : true) &&
  //           (heater != null
  //               ? element.characteristics.heater == heater
  //               : true) &&
  //           (climate != null
  //               ? element.characteristics.climate_control == climate
  //               : true) &&
  //           (selectedlist.contains(FilterPageTranslation.highspeed)
  //               ? element.features.highSpeed ==
  //                   selectedlist.contains(FilterPageTranslation.highspeed)
  //               : true) &&
  //           (selectedlist.contains(FilterPageTranslation.american)
  //               ? element.features.american ==
  //                   selectedlist.contains(FilterPageTranslation.american)
  //               : true) &&
  //           (selectedlist.contains(FilterPageTranslation.slowMoving)
  //               ? element.features.slowMoving ==
  //                   selectedlist.contains(FilterPageTranslation.slowMoving)
  //               : true) &&
  //           (selectedlist.contains(FilterPageTranslation.retro)
  //               ? element.features.retro ==
  //                   selectedlist.contains(FilterPageTranslation.retro)
  //               : true) &&
  //           (selectedlist.contains(FilterPageTranslation.closed)
  //               ? element.features.closed ==
  //                   selectedlist.contains(FilterPageTranslation.closed)
  //               : true) &&
  //           (selectedlist.contains(FilterPageTranslation.withFlybridge)
  //               ? element.features.withFlybridge ==
  //                   selectedlist.contains(FilterPageTranslation.withFlybridge)
  //               : true) &&
  //           (selectedlist.contains(FilterPageTranslation.withPanoramicWindows)
  //               ? element.features.withPanoramicWindows ==
  //                   selectedlist
  //                       .contains(FilterPageTranslation.withPanoramicWindows)
  //               : true))
  //       .toList();
  //   filterValue = true;
  // }

// rest function.
  rest() {
    startPrice = 1;
    endPrice = 10000;
    startLength = 1;
    endLength = 10000;
    startRating = 1;
    endRating = 5;
    shipType = null;
    toilet = null;
    rainValue = null;
    bimini = null;
    bluetooth = null;
    mask = null;
    shower = null;
    fridge = null;
    blankets = null;
    table = null;
    glasses = null;
    bathing = null;
    fishEcho = null;
    heater = null;
    climate = null;
    selectedlist = [];
    filterList = [];
    filterValue = false;
    filterList = null;
  }

  // search filter function
  searchFilter(selectedCityName) async {
    if (boatList == null || boatList!.isEmpty == true) {
      await readJsondata();
    }
    filterList = boatList!
        .where((element) => (element.city == selectedCityName))
        .toList();
    searchValue = true;
    notifyListeners();
  }

  moveToSelectedCity(selectedCityValue) {
    selectedCityV = selectedCityValue;
    filterList = boatList.where((e) => e.city == selectedCityValue).toList();
    notifyListeners();
  }
}
