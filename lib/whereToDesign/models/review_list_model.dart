import 'dart:convert';

import 'review_model.dart';

class ReviewsListModel {
  List<ReviewModel> reviews;

  ReviewsListModel({required this.reviews});

  // Factory method to parse JSON into a ReviewsList object
  factory ReviewsListModel.fromJson(Map<String, dynamic> json) {
    // var list = json['reviews'] as List;
    List list = json['reviews'];
    List<ReviewModel> reviewsList =
        list.map((i) => ReviewModel.fromJson(i)).toList();

    return ReviewsListModel(reviews: reviewsList);
  }
}

// Function to parse JSON string
ReviewsListModel parseCities(String jsonString) {
  final Map<String, dynamic> jsonData = json.decode(jsonString);
  return ReviewsListModel.fromJson(jsonData);
}
