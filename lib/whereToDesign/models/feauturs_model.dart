class FeautursModel {
  final bool highSpeed;
  final bool american;
  final bool slowMoving;
  final bool retro;
  final bool closed;
  final bool withFlybridge;
  final bool withPanoramicWindows;

  FeautursModel({
    required this.highSpeed,
    required this.american,
    required this.slowMoving,
    required this.retro,
    required this.closed,
    required this.withFlybridge,
    required this.withPanoramicWindows,
  });
  factory FeautursModel.fromJson(Map<String, dynamic> json) {
    return FeautursModel(
      highSpeed: json['high_speed'],
      american: json['american'],
      slowMoving: json['slow_moving'],
      retro: json['retro'],
      closed: json['closed'],
      withFlybridge: json['with_flybridge'],
      withPanoramicWindows: json['with_panoramic_windows'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'high_speed': highSpeed,
      'american': american,
      'slow_moving': slowMoving,
      'retro': retro,
      'shower': closed,
      'with_flybridge': withFlybridge,
      'with_panoramic_windows': withPanoramicWindows,
    };
  }
}
