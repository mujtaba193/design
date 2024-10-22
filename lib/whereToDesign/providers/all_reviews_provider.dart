import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/all_reviews_model.dart';

final allReviewsProvider = FutureProvider(
  (ref) async {
    late BoatReviews reviewsList;
    var jsonStr = await rootBundle.loadString('assets/all_reviews.json');
    final Map<String, dynamic> jsonData = json.decode(jsonStr);
    reviewsList = BoatReviews.fromJson(jsonData);
    return reviewsList;
  },
);
