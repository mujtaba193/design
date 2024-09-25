import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'hive_class.dart';

class SearchFilterTranslation {
  SearchFilterTranslation._();

  static final Map<String, Map<String, String>> translation = {
    'en': {
      'apply': 'Apply',
      'filter': 'Filter',
      'city': 'city',
      'from': 'From',
      'to': 'To',
      'withCaptain': 'With Captain',
      'withoutCaptain': 'Without Captain',
      'withoutLicense': 'Without license',
      'withLicense': 'With license',
      'selectDT': 'Select date and time',
      'duration': 'Duration (hours)',
      'guests': 'Guests',
      'aduls': 'aduls',
      'children': 'Children',
      'pets': 'Pets are allowed',
      'disabilities': 'Accessible for persons with disabilities',
    },
    'ru': {
      'apply': 'применять',
      'filter': 'Фильтр',
      'city': 'Город',
      'from': 'От',
      'to': 'До',
      'withCaptain': 'С капитаном',
      'withoutCaptain': 'Без капитана',
      'withoutLicense': 'Без лицензии',
      'withLicense': 'С лицензией',
      'selectDT': 'Выберите дату и время',
      'duration': 'Продолжительность (часов)',
      'guests': 'Гости',
      'aduls': 'взрослые',
      'children': 'Дети',
      'pets': 'Домашние животные разрешены.',
      'disabilities': 'Доступно для лиц с ограниченными возможностями',
    }
  };

  static String translate(String key) {
    final languageMap = translation[
        Hive.box(HiveBox.langbox).get(HiveBox.newLang) ??
            (PlatformDispatcher.instance.locale.languageCode == 'ru'
                ? 'ru'
                : 'en')];
    return languageMap != null ? languageMap[key] ?? key : key;
  }

  static String get apply => translate('apply');
  static String get filter => translate('filter');
  static String get city => translate('city');
  static String get from => translate('from');
  static String get to => translate('to');
  static String get withCaptain => translate('withCaptain');
  static String get withoutCaptain => translate('withoutCaptain');
  static String get withoutLicense => translate('withoutLicense');
  static String get withLicense => translate('withLicense');
  static String get selectDT => translate('selectDT');
  static String get duration => translate('duration');
  static String get guests => translate('guests');
  static String get aduls => translate('aduls');
  static String get children => translate('children');
  static String get pets => translate('pets');
  static String get disabilities => translate('disabilities');
}
