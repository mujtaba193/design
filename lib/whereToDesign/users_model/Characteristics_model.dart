class CharModel {
  final String shipyard;
  final String model;
  final int year;
  final int length;
  final int width;
  final String power;
  final String walking_speed;
  final int cabins;
  final int sleeping_places;

  CharModel(
      {required this.shipyard,
      required this.model,
      required this.year,
      required this.length,
      required this.width,
      required this.power,
      required this.walking_speed,
      required this.cabins,
      required this.sleeping_places});
  factory CharModel.fromJson(Map<String, dynamic> json) {
    return CharModel(
        shipyard: json['shipyard'],
        model: json['model'],
        year: json['year'],
        length: json['length'],
        width: json['width'],
        power: json['power'],
        walking_speed: json['walking_speed'],
        cabins: json['cabins'],
        sleeping_places: json['sleeping_places']);
  }
  Map<String, dynamic> toJson() {
    return {
      'shipyard': shipyard,
      'model': model,
      'year': year,
      'length': length,
      'width': width,
      'power': power,
      'walking_speed': walking_speed,
      'cabins': cabins,
      'sleeping_places': sleeping_places
    };
  }
}
