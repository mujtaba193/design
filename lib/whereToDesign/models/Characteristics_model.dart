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
  final bool rain_awning;
  final bool bimini_sunshade;
  final bool bluetooth_audio_system;
  final bool snorkeling_mask;
  final bool shower;
  final bool fridge;
  final bool blankets;
  final bool table;
  final bool glasses;
  final bool bathing_platform;
  final bool fish_echo_sounder;
  final bool heater;
  final bool climate_control;

  CharModel({
    required this.shipyard,
    required this.model,
    required this.year,
    required this.length,
    required this.width,
    required this.power,
    required this.walking_speed,
    required this.cabins,
    required this.sleeping_places,
    required this.rain_awning,
    required this.bimini_sunshade,
    required this.bluetooth_audio_system,
    required this.snorkeling_mask,
    required this.shower,
    required this.fridge,
    required this.blankets,
    required this.table,
    required this.glasses,
    required this.bathing_platform,
    required this.fish_echo_sounder,
    required this.heater,
    required this.climate_control,
  });
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
      sleeping_places: json['sleeping_places'],
      rain_awning: json['rain_awning'],
      bimini_sunshade: json['bimini_sunshade'],
      bluetooth_audio_system: json['bluetooth_audio_system'],
      snorkeling_mask: json['snorkeling_mask'],
      shower: json['shower'],
      fridge: json['fridge'],
      blankets: json['blankets'],
      table: json['table'],
      glasses: json['glasses'],
      bathing_platform: json['bathing_platform'],
      fish_echo_sounder: json['fish_echo_sounder'],
      heater: json['heater'],
      climate_control: json['climate_control'],
    );
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
      'sleeping_places': sleeping_places,
      'rain_awning': rain_awning,
      'bimini_sunshade': bimini_sunshade,
      'bluetooth_audio_system': bluetooth_audio_system,
      'snorkeling_mask': snorkeling_mask,
      'shower': shower,
      'fridge': fridge,
      'blankets': blankets,
      'table': table,
      'glasses': glasses,
      'bathing_platform': bathing_platform,
      'fish_echo_sounder': fish_echo_sounder,
      'heater': heater,
      'climate_control': climate_control,
    };
  }
}
/*   "rain_awning": true,
      "bimini_sunshade": false,
      "bluetooth_audio_system": false,
      "snorkeling_mask": true,
      "shower": false,
      "fridge": true,
      "blankets": false,
      "table": true,
      "glasses": true,
      "bathing_platform": true,
      "fish_echo_sounder": true,
      "heater": false,
      "climate_control": true */

class Characteristic {
  String? shipyard;
  String? model;
  int? year;
  double? length;
  double? width;
  String? power;
  String? walkingSpeed;
  int? cabins;
  int? sleepingPlaces;
  bool? rainAwning;
  bool? biminiSunshade;
  bool? bluetoothAudioSystem;
  bool? snorkelingMask;
  bool? shower;
  bool? fridge;
  bool? blankets;
  bool? table;
  bool? glasses;
  bool? bathingPlatform;
  bool? fishEchoSounder;
  bool? heater;
  bool? climateControl;

  Characteristic({
    this.shipyard,
    this.model,
    this.year,
    this.length,
    this.width,
    this.power,
    this.walkingSpeed,
    this.cabins,
    this.sleepingPlaces,
    this.rainAwning,
    this.biminiSunshade,
    this.bluetoothAudioSystem,
    this.snorkelingMask,
    this.shower,
    this.fridge,
    this.blankets,
    this.table,
    this.glasses,
    this.bathingPlatform,
    this.fishEchoSounder,
    this.heater,
    this.climateControl,
  });

  factory Characteristic.fromJson(Map<String, dynamic> json) {
    return Characteristic(
      shipyard: json['shipyard'],
      model: json['model'],
      year: json['year'],
      length: json['length'].toDouble(),
      width: json['width'].toDouble(),
      power: json['power'],
      walkingSpeed: json['walking_speed'],
      cabins: json['cabins'],
      sleepingPlaces: json['sleeping_places'],
      rainAwning: json['rain_awning'],
      biminiSunshade: json['bimini_sunshade'],
      bluetoothAudioSystem: json['bluetooth_audio_system'],
      snorkelingMask: json['snorkeling_mask'],
      shower: json['shower'],
      fridge: json['fridge'],
      blankets: json['blankets'],
      table: json['table'],
      glasses: json['glasses'],
      bathingPlatform: json['bathing_platform'],
      fishEchoSounder: json['fish_echo_sounder'],
      heater: json['heater'],
      climateControl: json['climate_control'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shipyard': shipyard,
      'model': model,
      'year': year,
      'length': length,
      'width': width,
      'power': power,
      'walking_speed': walkingSpeed,
      'cabins': cabins,
      'sleeping_places': sleepingPlaces,
      'rain_awning': rainAwning,
      'bimini_sunshade': biminiSunshade,
      'bluetooth_audio_system': bluetoothAudioSystem,
      'snorkeling_mask': snorkelingMask,
      'shower': shower,
      'fridge': fridge,
      'blankets': blankets,
      'table': table,
      'glasses': glasses,
      'bathing_platform': bathingPlatform,
      'fish_echo_sounder': fishEchoSounder,
      'heater': heater,
      'climate_control': climateControl,
    };
  }
}
