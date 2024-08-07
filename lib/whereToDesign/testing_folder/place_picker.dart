import 'dart:io';

//import 'package:design/google_place_picker/src/api_keys.dart';
//import 'package:design/google_place_picker/src/models/pick_result.dart';
import 'package:design/google_place_picker/src/place_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../google_place_picker/src/api_keys.dart';
import '../../google_place_picker/src/models/pick_result.dart';

class TestPlacePicker extends StatefulWidget {
  const TestPlacePicker({super.key});

  @override
  State<TestPlacePicker> createState() => _TestPlacePickerState();
}

class _TestPlacePickerState extends State<TestPlacePicker> {
  static final kInitialPosition = LatLng(59.976705, 30.213108);
  PickResult? selectedPlace;
  @override
  Widget build(BuildContext context) {
    return PlacePicker(
      resizeToAvoidBottomInset: false, // only works in page mode, less flickery
      apiKey: Platform.isAndroid ? APIKeys.androidApiKey : APIKeys.iosApiKey,
      hintText: "Find a place ...",
      searchingText: "Please wait ...",
      selectText: "Select place",
      outsideOfPickAreaText: "Place not in area",
      initialPosition: kInitialPosition,
      useCurrentLocation: true,
      selectInitialPosition: true,
      usePinPointingSearch: true,
      usePlaceDetailSearch: true,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: true,
      ignoreLocationPermissionErrors: true,
      onMapCreated: (GoogleMapController controller) {
        print("Map created");
      },
      onPlacePicked: (PickResult result) {
        print("Place picked: ${result.formattedAddress}");
        setState(() {
          selectedPlace = result;
          // Navigator.of(context).pop();
        });
      },
      onMapTypeChanged: (MapType mapType) {
        print("Map type changed to ${mapType.toString()}");
      },
    );
  }
}
