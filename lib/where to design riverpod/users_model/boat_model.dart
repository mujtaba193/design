import 'dart:convert';

import 'package:design/whereToDesign/users_model/Characteristics_model.dart';
import 'package:design/whereToDesign/users_model/address_model.dart';

List<BoatModelRiverPod> boatListFromJson(String str) =>
    List<BoatModelRiverPod>.from(
        json.decode(str).map((x) => BoatModelRiverPod.fromJson(x)));

String boatListToJson(List<BoatModelRiverPod> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BoatModelRiverPod {
  final String boatName;
  final List<String> imageList;
  final List<String> reviews;
  final List<String> userIds;
  final double minimumPrice;
  final double finalPrice;
  DateTime bookedStartTime;
  DateTime bookedFinishTime;
  final int guests;
  final String city;
  final String description;
  final List<String> options;
  final CharModel characteristics;
  final AddressModel address;

  BoatModelRiverPod(
      {required this.boatName,
      required this.imageList,
      required this.reviews,
      required this.userIds,
      required this.minimumPrice,
      required this.finalPrice,
      required this.bookedFinishTime,
      required this.bookedStartTime,
      required this.guests,
      required this.city,
      required this.description,
      required this.options,
      required this.characteristics,
      required this.address});

  factory BoatModelRiverPod.fromJson(Map<String, dynamic> json) {
    return BoatModelRiverPod(
        boatName: json['boatName'],
        imageList: List<String>.from(json['imageList']),
        reviews: List<String>.from(json['reviews']),
        userIds: List<String>.from(json['userIds']),
        minimumPrice: json['minimumPrice'].toDouble(),
        finalPrice: json['finalPrice'].toDouble(),
        bookedStartTime: DateTime.parse(json['booked_start_time']),
        bookedFinishTime: DateTime.parse(json['booked_finish_time']),
        guests: json['guests'],
        city: json['city'],
        description: json['description'],
        options: List<String>.from(json['options']),
        characteristics: CharModel.fromJson(json['characteristics']),
        address: AddressModel.fromJson(json['address']));
  }

  Map<String, dynamic> toJson() {
    return {
      'boatName': boatName,
      'imageList': imageList,
      'reviews': reviews,
      'userIds': userIds,
      'minimumPrice': minimumPrice,
      'finalPrice': finalPrice,
      'booked_start_time': bookedStartTime.toIso8601String(),
      'booked_finish_time': bookedFinishTime.toIso8601String(),
      'guests': guests,
      'city': city,
      'description': description,
      'options': options,
      'characteristics': characteristics,
      'address': address
    };
  }
}
