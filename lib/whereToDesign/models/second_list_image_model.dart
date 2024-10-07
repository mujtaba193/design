class SecondLIModel {
  final String cityName;
  final String eventName;
  DateTime date;
  final double minHours;
  final List<String> eventImage;
  SecondLIModel(
      {required this.cityName,
      required this.eventName,
      required this.date,
      required this.minHours,
      required this.eventImage});

  factory SecondLIModel.fromJson(Map<String, dynamic> json) {
    return SecondLIModel(
      cityName: json['city_name'],
      eventName: json['event_name'],
      date: DateTime.parse(json['date']),
      minHours: json['min_hours'].toDouble(),
      eventImage: List<String>.from(json['event_photos']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'city_name': cityName,
      'event_name': eventName,
      'date': date.toIso8601String(),
      'min_hours': minHours,
      'even_photos': eventImage,
    };
  }
}
