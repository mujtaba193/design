import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'hive_class.dart';

class SearchFilterTranslation {
  SearchFilterTranslation._();

  static final Map<String, Map<String, String>> translation = {
    'en': {
      'confirm': 'Confirm',
      'apply': 'Apply',
      'filter': 'Filters',
      'city': 'City',
      'from': 'From',
      'to': 'To',
      'withCaptain': 'With Captain',
      'withoutCaptain': 'Without Captain',
      'withoutLicense': 'Without license',
      'norights': 'No rights',
      'havegimsrights': 'Have GIMS rights',
      'withLicense': 'With license',
      'selectDT': 'Select date and time',
      'duration': 'Duration (hours)',
      'guests': 'Guests',
      'adults': 'Adults',
      'children': 'Children',
      'pets': 'Pets allowed',
      'disabilities': 'Disability Accessible',
    },
    'ru': {
      'confirm': 'Подтверждать',
      'apply': 'применять',
      'filter': 'Фильтр',
      'city': 'Город',
      'from': 'От',
      'to': 'До',
      'withCaptain': 'С капитаном',
      'withoutCaptain': 'Без капитана',
      'withoutLicense': 'Без лицензии',
      'norights': 'Нет прав',
      'havegimsrights': 'Иметь права GIMS',
      'withLicense': 'С лицензией',
      'selectDT': 'Выберите дату и время',
      'duration': 'Продолжительность (часов)',
      'guests': 'Гости',
      'adults': 'взрослые',
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

//Have GIMS rights
  static String get confirm => translate('confirm');
  static String get apply => translate('apply');
  static String get filter => translate('filter');
  static String get city => translate('city');
  static String get from => translate('from');
  static String get to => translate('to');
  static String get withCaptain => translate('withCaptain');
  static String get withoutCaptain => translate('withoutCaptain');
  static String get norights => translate('norights');
  static String get havegimsrights => translate('havegimsrights');
  static String get withoutLicense => translate('withoutLicense');
  static String get withLicense => translate('withLicense');
  static String get selectDT => translate('selectDT');
  static String get duration => translate('duration');
  static String get guests => translate('guests');
  static String get adults => translate('adults');
  static String get children => translate('children');
  static String get pets => translate('pets');
  static String get disabilities => translate('disabilities');
}
