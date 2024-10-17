import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/review_list_model.dart';

final reviewProvider = FutureProvider<ReviewsListModel>((ref) async {
  late ReviewsListModel reviewList;

  var jsonStr = await rootBundle.loadString('assets/reviews.json');

  // Decode the JSON string into a Map
  final Map<String, dynamic> jsonData = json.decode(jsonStr);

  // Parse the JSON data into the CityList model
  reviewList = ReviewsListModel.fromJson(jsonData);

  return reviewList;
});
