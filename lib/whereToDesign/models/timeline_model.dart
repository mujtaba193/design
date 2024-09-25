class TimeLineModel {
  final DateTime startTime;
  final DateTime endTime;
  final int price;

  TimeLineModel(
      {required this.startTime, required this.endTime, required this.price});

  factory TimeLineModel.fromJson(Map<String, dynamic> json) {
    return TimeLineModel(
        startTime: DateTime.parse(json['start_time']),
        endTime: DateTime.parse(json['end_time']),
        price: json['price']);
  }
  Map<String, dynamic> toJson() {
    return {
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'price': price
    };
  }
}
