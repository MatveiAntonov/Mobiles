import 'package:flutter/material.dart';
import 'package:lab1/pages/ListPage.dart';
import 'package:lab1/pages/MapPage.dart';
import 'package:lab1/pages/SettingsPage.dart';
import 'package:lab1/models/settings.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() => runApp(MaterialApp(
  home: const Main(page: 0,),
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
      primarySwatch: Colors.red,
      scaffoldBackgroundColor: const Color(0xFFFD7010)
  ),
));

class Main extends StatefulWidget {
  final int page;
  const Main({Key? key, required this.page}) : super(key: key);
  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int pageIndex = 0;

  final pages = [
    const ListPage(),
    const MapPage(),
    const SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();

    pageIndex = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final icons = <Widget>[
      const Icon(Icons.list_alt, size: 35,),
      const Icon(Icons.location_on, size: 35,),
      const Icon(Icons.settings, size: 35,)
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your weather',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25 * Settings.fontCoef,
              color: Settings.fontColor
          ),
        ),
        centerTitle: true,
      ),
      body: pages[pageIndex],
      bottomNavigationBar:
      CurvedNavigationBar(
        key: navigationKey,
        index: pageIndex,
        color: const Color(0xFFFD2020),
        items: icons,
        height: 50,
        backgroundColor: Colors.transparent,
        onTap: (index) => setState(() => pageIndex = index),
      ),
    );
  }
}
