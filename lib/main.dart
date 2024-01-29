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

MyTheme myTheme = new MyTheme();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);


  SharedPreferences.getInstance().then((instance) async {
    setThemePosition();
    runApp(MyApp());
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
    print("ass---true---${myTheme.currentTheme()}");

    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        const Locale('en', 'US'), // English US
        const Locale('en', 'GB'), // English UK
        // ... other locales the app supports
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: primaryColor),
          primaryColor: primaryColor,
          dialogBackgroundColor: lightCellColor,
          brightness: Brightness.light,
          splashColor: Colors.transparent,
          backgroundColor: Colors.white),
      themeMode: myTheme.currentTheme(),
      darkTheme: ThemeData(
        splashFactory: NoSplash.splashFactory,
        primaryColor: primaryColor,
        brightness: Brightness.dark,
        splashColor: Colors.transparent,
        dialogBackgroundColor: darkCellColor,
        backgroundColor: darkBackgroundColor,
      ),
      home: IntroPage(),
    );
  }
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  bool _isSignIn = false;
  bool _isIntro = false;

  // bool _isFirstTime = false;

  @override
  void initState() {
    super.initState();
    signInValue();
    Future.delayed(Duration(seconds: 0), () {
      setThemePosition(context: context);
      setState(() {});
    });

    Timer(Duration(seconds: 3), () {
      if (_isIntro) {
        Navigator.pushReplacement(

            context, MaterialPageRoute(builder: (context) => IntroPage()));
      } else if (!_isSignIn) {
        print("intro----$_isSignIn");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SignInPage(),
            ));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(),
            ));
      }
    });
  }

  void signInValue() async {
    _isIntro = await PrefData.getIsIntro();
    _isSignIn = await PrefData.getIsSignIn();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // setThemePosition(context: context);
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarIconBrightness: Brightness.dark,
          // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: primaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              assetsPath + "splash_icon.png",
              height: getScreenPercentSize(context, 12),
              color: Colors.white,
            ),
            SizedBox(height: getScreenPercentSize(context, 1.2),),
            Center(
              child: getSplashTextWidget(
                  "Petshops",
                  Colors.white,
                  getScreenPercentSize(context, 4),
                  FontWeight.w500,
                  TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
