import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:lab1/models/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final listItems = ['x1', 'x1.2', 'x1.4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.fontSize,
                        style: TextStyle(
                            fontSize: 26 * Settings.fontCoef,
                            color: Settings.fontColor
                        ),
                      ),
                    ]
                ),
                Container(
                    width: 130 * Settings.fontCoef,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: Settings.listItem,
                        isExpanded: true,
                        iconSize: 36,
                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black,),
                        items: listItems.map(buildMenuItem).toList(),
                        onChanged: (value) => {
                          Settings.setFontCoef(value),
                          setState(() => Settings.listItem = value)
                        },
                      ),
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.fontColor,
                        style: TextStyle(
                            fontSize: 26 * Settings.fontCoef,
                            color: Settings.fontColor
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Settings.fontColor
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // padding: const EdgeInsets.symmetric(horizontal: 10)
                  ),
                  onPressed: () => pickColor(context),
                  child: Text(
                      AppLocalizations.of(context)!.changeColor,
                      style: TextStyle(
                          fontSize: 23 * Settings.fontCoef,
                          color: Settings.fontColor
                      )
                  ),
                ),
              ],
            )
          ],
        )
      )
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          item,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23 * Settings.fontCoef,
              color: Colors.black
          ),
        ),
      )
  );

  Widget buildColorPicker() => ColorPicker(
      labelTypes: [],
      enableAlpha: false,
      pickerColor: Settings.fontColor,
      onColorChanged: (color) => setState(() => Settings.fontColor = color)
  );



  void pickColor(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.pickColor,
          style: TextStyle(
            color: Settings.fontColor
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildColorPicker(),
            TextButton(
              onPressed: () => {
                Navigator.of(context).pop(),
              },
              child: Text(
                AppLocalizations.of(context)!.select,
                style: const TextStyle(
                    fontSize: 23,
                    color: Colors.blue
                ),
              ),
            ),
          ],
        )
      )
  );
}
