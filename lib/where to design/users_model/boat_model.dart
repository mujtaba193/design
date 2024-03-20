class BoatModel {
  final String boatName;
  final List<String> imageList;
  final List<String> reviews;
  final List<String> userIds;
  final double minimumPrice;
  final double finalPrice;

  BoatModel({
    required this.boatName,
    required this.imageList,
    required this.reviews,
    required this.userIds,
    required this.minimumPrice,
    required this.finalPrice,
  });

  factory BoatModel.fromJson(Map<String, dynamic> json) {
    return BoatModel(
      boatName: json['boatName'],
      imageList: List<String>.from(json['imageList']),
      reviews: List<String>.from(json['reviews']),
      userIds: List<String>.from(json['userIds']),
      minimumPrice: json['minimumPrice'].toDouble(),
      finalPrice: json['finalPrice'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'boatName': boatName,
      'imageList': imageList,
      'reviews': reviews,
      'userIds': userIds,
      'minimumPrice': minimumPrice,
      'finalPrice': finalPrice,
    };
  }
}
