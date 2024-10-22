class ReviewModel {
  final String boatId;
  String reviewId; //userName
  String reviewDescription;
  String userId;
  String userName;
  String userPhoto;
  String date;
  int rating;

  ReviewModel({
    required this.boatId,
    required this.reviewId,
    required this.reviewDescription,
    required this.userId,
    required this.userName,
    required this.userPhoto,
    required this.date,
    required this.rating,
  });

  // Factory method to parse JSON into a Review object
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      boatId: json['boatId'],
      reviewId: json['reviewId'],
      reviewDescription: json['reviewDescription'],
      userId: json['userId'],
      userName: json['userName'],
      userPhoto: json['userPhoto'],
      date: json['date'],
      rating: json['rating'],
    );
  }

  // Method to convert Review object into JSON format
  Map<String, dynamic> toJson() {
    return {
      'boatId': boatId,
      'reviewId': reviewId,
      'reviewDescription': reviewDescription,
      'userId': userId,
      'userName': userName,
      'userPhoto': userPhoto,
      'date': date,
      'rating': rating,
    };
  }
}
