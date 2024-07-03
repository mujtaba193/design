import 'package:hive/hive.dart';

import 'hive_class.dart';

class ProfiePageTranslation {
  ProfiePageTranslation._();

  static final Map<String, Map<String, String>> translation = {
    'en': {
      'name': 'Name',
      'hintName': 'Enter your name',
      'familyName': 'Family Name',
      'hintFamily': 'Enter your family name',
      'phoneNum': 'Phone Number',
      'hintPhon': 'Enter your phone number',
      'mail': 'Mail',
      'hintMail': 'Enter your email',
      'profileSettings': 'Profile Setting',
      'language': 'language',
      'languageType': 'English',
      'pushNotifications': 'Push-notifications',
      'bookingInformations': 'Booking Information',
      'chatMessage': 'Chat Message',
      'news': 'News and Promotions'
    },
    'ru': {
      'name': 'Имя',
      'hintName': 'Введите ваше имя',
      'familyName': 'Фамилия',
      'hintFamily': 'Введите свою фамилию',
      'phoneNum': 'Телефон',
      'hintPhon': 'Введите свой номер телефона',
      'mail': 'почта',
      'hintMail': 'Введите свою электронную почту',
      'profileSettings': 'Настройки Профиля',
      'language': 'язык',
      'languageType': 'русский',
      'pushNotifications': 'Push-уведомление ',
      'bookingInformations': 'информация о бронированию',
      'chatMessage': 'Собщения в чате',
      'news': 'Новости и акции'
    }
  };

  // static String? languageCode;
  static String translate(String key) {
    final languageMap =
        translation[Hive.box(HiveBox.langbox).get(HiveBox.newLang)];
    return languageMap != null ? languageMap[key] ?? key : key;
  }

  static String get name => translate('name');
  static String get hintName => translate('hintName');
  static String get familyName => translate('familyName');
  static String get hintFamily => translate('hintFamily');
  static String get phoneNum => translate('phoneNum');
  static String get hintPhon => translate('hintPhon');
  static String get mail => translate('mail');
  static String get hintMail => translate('hintMail');
  static String get profileSettings => translate('profileSettings');
  static String get language => translate('language');
  static String get languageType => translate('languageType');
  static String get pushNotifications => translate('pushNotifications');
  static String get bookingInformations => translate('bookingInformations');
  static String get chatMessage => translate('chatMessage');
  static String get news => translate('news');
}
