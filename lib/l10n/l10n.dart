import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('fr'),
    const Locale('ru'),
    const Locale('de'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'de':
        return '🇩🇪';
      case 'fr':
        return '🇫🇷';
      case 'ru':
        return '🇷🇺';
      case 'en':
      default:
        return '🇺🇸';
    }
  }
}