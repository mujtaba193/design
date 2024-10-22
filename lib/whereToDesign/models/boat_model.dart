import 'package:design/whereToDesign/models/Characteristics_model.dart';
import 'package:design/whereToDesign/models/address_model.dart';
import 'package:design/whereToDesign/models/timeline_model.dart';

import 'feauturs_model.dart';

class BoatModel {
  final String boatId;
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
  final FeautursModel features;
  final List<AddressModel> address;
  final Map<DateTime, int> datasets;
  final List<TimeLineModel> timeline;
  final double rating;
  final String shipType;
  final String toiletOnBoard;

  BoatModel(
      {required this.boatId,
      required this.boatName,
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
      required this.features,
      required this.address,
      required this.datasets,
      required this.timeline,
      required this.rating,
      required this.shipType,
      required this.toiletOnBoard});

  factory BoatModel.fromJson(Map<String, dynamic> json) {
    return BoatModel(
      boatId: json['boatId'],
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
      features: FeautursModel.fromJson(json['features']),
      address: List<dynamic>.from(json['address'])
          .map((e) => AddressModel.fromJson(e))
          .toList(),
      datasets: Map<DateTime, int>.from(json['datasets'].map(
        (key, value) => MapEntry(DateTime.parse(key), value),
      )),
      timeline: List<dynamic>.from(json['timeline'])
          .map((e) => TimeLineModel.fromJson(e))
          .toList(),
      rating: json['rating'].toDouble(),
      shipType: json['ship_type'],
      toiletOnBoard: json['toilet_on_board'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'boatId': boatId,
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
      'features': features,
      'address': address.map((e) => e.toJson()).toList(),
      'datasets': datasets.map((key, value) => MapEntry(key.toString(), value)),
      'timeline': timeline.map((e) => e.toJson()).toList(),
      'rating': rating,
      'ship_type': shipType,
      'toilet_on_board': toiletOnBoard,
    };
  }
}
