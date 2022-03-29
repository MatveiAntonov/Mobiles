import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab1/l10n/l10n.dart';
import 'package:lab1/models/settings.dart';

class LanguageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final flag = L10n.getFlag(locale.languageCode);

    return Center(
      child: CircleAvatar(
        backgroundColor: Settings.fontColor,
        radius: 35,
        child: Text(
            flag,
            style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}