import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'l10n/messages_all.dart';

class CustomLocalization {
  final String localName;

  CustomLocalization(this.localName);

  static Future<CustomLocalization> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      return CustomLocalization(localeName);
    });
  }

  static CustomLocalization of(BuildContext context) {
    return Localizations.of<CustomLocalization>(context, CustomLocalization);
  }

  String get selectFavorite {
    return Intl.message(
      'Select favorite applicaton',
      name: 'selectFavorite',
      desc: '',
      locale: localName,
    );
  }

  String get selectRightSwipe {
    return Intl.message(
      'Select right swipe',
      name: 'selectRightSwipe',
      desc: '',
      locale: localName,
    );
  }

  String get selectLeftSwipe {
    return Intl.message(
      'Select left swipe',
      name: 'selectLeftSwipe',
      desc: '',
      locale: localName,
    );
  }
}

class CustomLocalizationsDelegate
    extends LocalizationsDelegate<CustomLocalization> {
  const CustomLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ru'].contains(locale.languageCode);

  @override
  Future<CustomLocalization> load(Locale locale) {
    return CustomLocalization.load(locale);
  }

  @override
  bool shouldReload(CustomLocalizationsDelegate old) => false;
}
