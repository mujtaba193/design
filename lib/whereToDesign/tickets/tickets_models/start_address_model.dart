class StartAddressModel {
  final String name;
  final double latitude;
  final double longitude;

  StartAddressModel({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
  factory StartAddressModel.fromJson(Map<String, dynamic> json) {
    return StartAddressModel(
      name: json['name'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
