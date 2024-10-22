class BoatReviews {
  List<Boat> boatReviews;

  BoatReviews({required this.boatReviews});

  factory BoatReviews.fromJson(Map<String, dynamic> json) {
    return BoatReviews(
      boatReviews: List<Boat>.from(
          json['boatReviews'].map((boat) => Boat.fromJson(boat))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'boatReviews': boatReviews.map((boat) => boat.toJson()).toList(),
    };
  }
}

class Boat {
  String boatId;
  List<ReviewssModel> reviews;

  Boat({required this.boatId, required this.reviews});

  factory Boat.fromJson(Map<String, dynamic> json) {
    return Boat(
      boatId: json['boatId'],
      reviews: List<ReviewssModel>.from(
          json['reviews'].map((review) => ReviewssModel.fromJson(review))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'boatId': boatId,
      'reviews': reviews.map((review) => review.toJson()).toList(),
    };
  }
}

class ReviewssModel {
  String reviewDescription;
  String userId;
  String userName;
  String date;
  int rating;
  String userPhoto;
  List<String> likes;
  List<String> dislikes;
  List<String> photos;

  ReviewssModel(
      {required this.reviewDescription,
      required this.userId,
      required this.userName,
      required this.date,
      required this.rating,
      required this.userPhoto,
      required this.likes,
      required this.dislikes,
      required this.photos});

  factory ReviewssModel.fromJson(Map<String, dynamic> json) {
    return ReviewssModel(
      reviewDescription: json['reviewDescription'],
      userId: json['userId'],
      userName: json['userName'],
      date: json['date'],
      rating: json['rating'],
      userPhoto: json['userPhoto'],
      likes: List<String>.from(json['likes']),
      dislikes: List<String>.from(json['dislikes']),
      photos: List<String>.from(json['photos']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reviewDescription': reviewDescription,
      'userId': userId,
      'userName': userName,
      'date': date,
      'rating': rating,
      'userPhoto': userPhoto,
      'likes': likes,
      'dislikes': dislikes,
      'photos': photos,
    };
  }
}
