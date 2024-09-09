import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'hive_class.dart';

class FilterPageTranslation {
  FilterPageTranslation._();
  // Filter , Price for hour, for, to, Ship length,Rating,Ship type, motor, sailing, Toilet on board, not important, yes, no, Onboard amenities, Rain awning,
  // Bimini sunshade, Bluetooth audio system, Snorkling mask, Shower, Fridge, Blankets, Table, Glasses, Bathing platform, Fish echo sounder, Heater, Climate control,
  // Peculiarities , Apply

  static final Map<String, Map<String, String>> translation = {
    'en': {
      'filter': 'Filter',
      'price': 'Price for hour',
      'from': 'From',
      'to': 'To',
      'length': 'Ship length',
      'type': 'ship type',
      'rating': 'Rating',
      'motor': 'Motor',
      'sailing': 'Sailing',
      'toilet': 'Toilet on board',
      'notImportant': 'Not important',
      'yes': 'Yes',
      'no': 'No',
      'amenities': 'Onboard amenities',
      'rain': 'Rain awning',
      'biminiSunshade': 'Bimini sunshade',
      'bluetooth': 'Bluetooth audio system',
      'snorkeling': 'Snorkeling mask',
      'shower': 'Shower',
      'fridge': 'Fridge',
      'blankets': 'Blankets',
      'table': 'Table',
      'glasses': 'Glasses',
      'bathing': 'Bathing platform',
      'fishEcho': 'Fish echo sounder',
      'heater': 'Heater',
      'climate': 'Climate control',
      'apply': 'Apply',
      'features': 'Features',
      'highspeed': 'High-speed',
      'american': 'American',
      'slowMoving': 'Slow-moving',
      'retro': 'Retro',
      'closed': 'closed',
      'withFlybridge': 'With flybridge',
      'withPanoramicWindows': 'With panoramic windows',
    },
    'ru': {
      'filter': 'Фильтр',
      'price': 'Цена за час',
      'from': 'От',
      'to': 'До',
      'length': 'Длина корабля',
      'type': 'тип корабля',
      'rating': 'Рейтинг',
      'motor': 'Моторное',
      'sailing': 'Парусное',
      'toilet': 'Туалет на борту',
      'notImportant': 'Не важно',
      'yes': 'Да',
      'no': 'Нет',
      'amenities': 'Удобства на борту',
      'rain': 'Тент от дождя',
      'biminiSunshade': 'Бимини тент от солнца',
      'bluetooth': 'Аудиосистема Bluetooh',
      'snorkeling': 'Маска для снорклинга',
      'shower': 'Душ',
      'fridge': 'Холодильник',
      'blankets': 'Пледы',
      'table': 'Столик',
      'glasses': 'Бокалы',
      'bathing': 'Купальная платформа',
      'fishEcho': 'Рыбопоисковый эхолот',
      'heater': 'Отопитель',
      'climate': 'Климат контроль',
      'apply': 'применять',
      'features': 'Особенности',
      'highspeed': 'Скоростные',
      'american': 'Американские',
      'slowMoving': 'Тихоходные',
      'retro': 'Ретро',
      'closed': 'Закрытые',
      'withFlybridge': 'С флайбриджем',
      'withPanoramicWindows': 'С панорамными окнами',
    }
  };
  // 'High-speed',
  //   'American',
  //   'Slow-moving',
  //   'Retro',
  //   'Closed',
  //   'With flybridge',
  //   'With panoramic windows'
  // static String? languageCode;
  static String translate(String key) {
    final languageMap = translation[
        Hive.box(HiveBox.langbox).get(HiveBox.newLang) ??
            (PlatformDispatcher.instance.locale.languageCode == 'ru'
                ? 'ru'
                : 'en')];
    return languageMap != null ? languageMap[key] ?? key : key;
  }

  static String get filter => translate('filter');
  static String get price => translate('price');
  static String get from => translate('from');
  static String get to => translate('to');
  static String get length => translate('length');
  static String get type => translate('type');
  static String get rating => translate('rating');
  static String get motor => translate('motor');
  static String get sailing => translate('sailing');
  static String get toilet => translate('toilet');
  static String get notImportant => translate('notImportant');
  static String get yes => translate('yes');
  static String get no => translate('no');
  static String get amenities => translate('amenities');
  static String get rain => translate('rain');
  static String get biminiSunshade => translate('biminiSunshade');
  static String get bluetooth => translate('bluetooth');
  static String get snorkeling => translate('snorkeling');
  static String get shower => translate('shower');
  static String get fridge => translate('fridge');
  static String get blankets => translate('blankets');
  static String get table => translate('table');
  static String get glasses => translate('glasses');
  static String get bathing => translate('bathing');
  static String get fishEcho => translate('fishEcho');
  static String get heater => translate('heater');
  static String get climate => translate('climate');
  static String get apply => translate('apply');
  static String get features => translate('features');
  static String get highspeed => translate('highspeed');
  static String get american => translate('american');
  static String get slowMoving => translate('slowMoving');
  static String get retro => translate('retro');
  static String get closed => translate('closed');
  static String get withFlybridge => translate('withFlybridge');
  static String get withPanoramicWindows => translate('withPanoramicWindows');
}
