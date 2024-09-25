import 'package:design/whereToDesign/models/events_model.dart';

// City class to represent each city and its events
class City {
  final String cityName;
  final List<Event> events;

  City({required this.cityName, required this.events});

  factory City.fromJson(Map<String, dynamic> json) {
    var eventList = json['events'] as List;
    List<Event> eventObjs =
        eventList.map((eventJson) => Event.fromJson(eventJson)).toList();

    return City(
      cityName: json['city_name'],
      events: eventObjs,
    );
  }
}
