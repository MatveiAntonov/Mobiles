import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lab1/pages/ListPage.dart';
import 'package:lab1/pages/MapPage.dart';
import 'package:lab1/pages/SettingsPage.dart';
import 'package:lab1/models/settings.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lab1/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:lab1/provider/localProvider.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context) => LocalProvider(),
    builder: (context, child) {
      final provider = Provider.of<LocalProvider>(context);
      return MaterialApp(
        locale: provider.locale,
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: AnimatedSplashScreen(
            duration: 10,
            splash: 'assets/weather.png',
            nextScreen: const Main(page: 0),
            splashTransition: SplashTransition.rotationTransition,
            animationDuration: const Duration(milliseconds: 1500),
            splashIconSize: 200,
            backgroundColor: const Color(0xFFFD7010)
        ),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.red,
            scaffoldBackgroundColor: const Color(0xFFFD7010)
        ),
      );
    },
  ));
}

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
          AppLocalizations.of(context)!.yourWeather,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25 * Settings.fontCoef,
              color: Settings.fontColor
          ),
        ),
        centerTitle: true,
        actions: [
          LanguagePickerWidget(),
          const SizedBox(width: 12,)
        ],
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

  Widget LanguagePickerWidget() {
    final provider = Provider.of<LocalProvider>(context);
    final locale = provider.locale ?? Locale('en');

    return DropdownButtonHideUnderline(
      child: DropdownButton(
        onChanged: (_) {},
        value: locale ,
        icon: Container(width: 12),
        items: L10n.all.map(
              (locale) {
            final flag = L10n.getFlag(locale.languageCode);
            return DropdownMenuItem(
              child: Center(
                child: Text(
                  flag,
                  style: const TextStyle(fontSize: 32),
                ),
              ),
              value: locale,
              onTap: () {
                final provider = Provider.of<LocalProvider>(context, listen: false);
                provider.setLocale(locale);
              },
            );
          },
        ).toList(),
      ),
    );
  }
}
