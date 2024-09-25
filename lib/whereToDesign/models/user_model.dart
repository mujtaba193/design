class UsersModel {
  String name;
  String review;
  DateTime bookedStartTime;
  DateTime bookedFinishTime;

  UsersModel({
    required this.name,
    required this.review,
    required this.bookedStartTime,
    required this.bookedFinishTime,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      name: json['name'],
      review: json['review'],
      bookedStartTime: DateTime.parse(json['booked_start_time']),
      bookedFinishTime: DateTime.parse(json['booked_finish_time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'review': review,
      'booked_start_time': bookedStartTime.toIso8601String(),
      'booked_finish_time': bookedFinishTime.toIso8601String(),
    };
  }
}
