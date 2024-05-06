class AddressModel {
  final double latitude;
  final double longitude;
  final String username;

  AddressModel({
    required this.latitude,
    required this.longitude,
    required this.username,
  });
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
      username: json['username'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'username': username,
    };
  }
}
