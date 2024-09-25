// Event class to represent each event and its photos
class Event {
  final String eventName;
  final List<String> eventPhotos;

  Event({required this.eventName, required this.eventPhotos});

  factory Event.fromJson(Map<String, dynamic> json) {
    var photoList = json['event_photos'] as List;
    List<String> photoUrls =
        photoList.map((photo) => photo.toString()).toList();

    return Event(
      eventName: json['event_name'],
      eventPhotos: photoUrls,
    );
  }
}
