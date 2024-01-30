import 'dart:async';
import 'package:book_world/utils/Constant.dart';
import 'package:book_world/utils/CustomWidget.dart';
import 'package:book_world/utils/PrefData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'IntroPage.dart';
import 'MainPage.dart';
import 'SignInPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  bool _isSignIn = false;
  bool _isIntro = false;

  @override
  void initState() {
    super.initState();
    signInValue();
    Future.delayed(const Duration(seconds: 0), () {
      setThemePosition(context: context);
      setState(() {});
    });
    Timer(const Duration(seconds: 3), () {
      if (_isIntro) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const IntroPage()));
      } else if (!_isSignIn) {
        print("intro----$_isSignIn");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SignInPage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainPage()));
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
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: secondaryColor,
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: secondaryColor,
          systemNavigationBarColor: secondaryColor,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: secondaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "${assetsPath}splash_icon.png",
              height: getScreenPercentSize(context, 20),
            ),
            SizedBox(
              height: getScreenPercentSize(context, 1.2),
            ),
            Center(
              child: getSplashTextWidget(
                "Book World",
                secondaryPrimaryColor,
                getScreenPercentSize(context, 4),
                FontWeight.w500,
                TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
