class DestinationAddressModel {
  final String name;
  final double latitude;
  final double longitude;

  DestinationAddressModel({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
  factory DestinationAddressModel.fromJson(Map<String, dynamic> json) {
    return DestinationAddressModel(
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
