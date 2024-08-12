class AddressModel {
  final double latitude;
  final double longitude;

  AddressModel({
    required this.latitude,
    required this.longitude,
  });
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
