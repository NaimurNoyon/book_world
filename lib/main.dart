import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:book_world/utils/Constant.dart';
import 'package:book_world/utils/CustomWidget.dart';
import 'package:book_world/utils/MyTheme.dart';
import 'package:book_world/utils/PrefData.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'IntroPage.dart';
import 'MainPage.dart';
import 'SignInPage.dart';
import 'SplashScreen.dart';

MyTheme myTheme = MyTheme();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);


  SharedPreferences.getInstance().then((instance) async {
    setThemePosition();
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  _MyApp createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myTheme.switchTheme();
    setState(() {});
    myTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('en', 'US'), // English US
        Locale('en', 'GB'), // English UK
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: primaryColor),
          primaryColor: primaryColor,
          dialogBackgroundColor: lightCellColor,
          brightness: Brightness.light,
          splashColor: Colors.transparent,
          backgroundColor: Colors.white,
      ),
      themeMode: myTheme.currentTheme(),
      darkTheme: ThemeData(
        splashFactory: NoSplash.splashFactory,
        primaryColor: primaryColor,
        brightness: Brightness.dark,
        splashColor: Colors.transparent,
        dialogBackgroundColor: darkCellColor,
        backgroundColor: darkBackgroundColor,
      ),
      home: const SplashScreen(),
    );
  }
}


