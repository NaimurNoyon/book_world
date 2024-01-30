import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:book_world/SignUpPage.dart';
import 'package:book_world/utils/Constant.dart';
import 'package:book_world/utils/CustomWidget.dart';
import 'package:book_world/utils/DataFile.dart';
import 'package:book_world/utils/PrefData.dart';
import 'package:book_world/utils/SizeConfig.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'MainPage.dart';
import 'SignInPage.dart';
import 'model/IntroModel.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  _IntroPage createState() {
    return _IntroPage();
  }
}

class _IntroPage extends State<IntroPage> {
  int _position = 0;

  Future<bool> _requestPop() {
    exitApp();

    return Future.value(false);
  }

  final controller = PageController();

  List<IntroModel> introModelList = [];

  void skip() {
    PrefData.setIsIntro(false);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainPage()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    introModelList = DataFile.getIntroModel();
    Future.delayed(const Duration(seconds: 0), () {
      setThemePosition(context: context);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double firstSize = getScreenPercentSize(context, 55);
    double remainSize = getScreenPercentSize(context, 100) - firstSize;
    double defMargin = getScreenPercentSize(context, 2);
    setState(() {});

    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 0,
            backgroundColor: introModelList[_position].color!,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: introModelList[_position].color!,
              statusBarIconBrightness: Brightness.dark,
              // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons),\
              systemNavigationBarColor: introModelList[_position].color!,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
          ),
          backgroundColor: secondaryColor,
          body: Stack(
            children: [
              PageView.builder(
                controller: controller,
                itemBuilder: (context, position) {
                  return Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                          introModelList[position].color!,
                          introModelList[position].color!,
                          introModelList[position].endColor!
                        ])),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 300,
                            width: double.maxFinite,
                            margin: EdgeInsets.only(
                                bottom: getScreenPercentSize(context, 4)),
                            child: Image.asset(
                              assetsPath + introModelList[position].image!,
                              height: getScreenPercentSize(context, 85),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              horizontal: getHorizontalSpace(context)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: (defMargin * 3), bottom: (defMargin)),
                                child: getCustomTextWithFontFamilyWidget(
                                    introModelList[position].name!,
                                    textColor,
                                    getPercentSize(remainSize, 8),
                                    FontWeight.w500,
                                    TextAlign.start,
                                    2),
                              ),
                              getCustomTextWidget(
                                  introModelList[position].desc!,
                                  textColor,
                                  getScreenPercentSize(context, 2),
                                  FontWeight.w400,
                                  TextAlign.start,
                                  2),
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: getHorizontalSpace(context),
                                  top: defMargin * 2),
                              child: AnimatedSmoothIndicator(
                                activeIndex: _position,
                                count: introModelList.length,
                                effect: WormEffect(
                                    dotColor: Colors.white,
                                    activeDotColor: Colors.black,
                                    dotHeight:
                                        getScreenPercentSize(context, 1.2),
                                    dotWidth:
                                        getScreenPercentSize(context, 1.2)),
                              ),
                            ))
                      ],
                    ),
                  );
                },
                itemCount: introModelList.length,
                onPageChanged: _onPageViewChange,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: getHorizontalSpace(context),
                      vertical: getScreenPercentSize(context, 4)),
                  child: Row(
                    children: [
                      Visibility(
                        visible: (_position <= 2),
                        child: Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              skip();
                            },
                            child: getTextWidget(
                                "Skip",
                                textColor,
                                getScreenPercentSize(context, 2),
                                FontWeight.bold,
                                TextAlign.start),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: (_position == 3),
                        child: Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignInPage(),
                                  ));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: getWidthPercentSize(context, 3)),
                              height: getScreenPercentSize(context, 7),
                              decoration: ShapeDecoration(
                                color: '#FFEDB4'.toColor(),
                                shadows: [
                                  BoxShadow(
                                      color: textColor.withOpacity(0.1),
                                      blurRadius: 2,
                                      spreadRadius: 1,
                                      offset: const Offset(0, 4))
                                ],
                                shape: SmoothRectangleBorder(
                                  side:
                                      const BorderSide(color: Colors.white, width: 2),
                                  borderRadius: SmoothBorderRadius(
                                    cornerRadius:
                                        getScreenPercentSize(context, 1.8),
                                    cornerSmoothing: 0.8,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: getTextWidget(
                                    'Sign In',
                                    textColor,
                                    getScreenPercentSize(context, 2),
                                    FontWeight.bold,
                                    TextAlign.center),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (_position == 3) {
                              PrefData.setIsIntro(false);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpPage(),
                                  ));
                            } else {
                              if (_position < (introModelList.length - 1)) {
                                setState(() {
                                  _position = _position + 1;
                                  controller.jumpToPage(_position);
                                });
                              } else {
                                skip();
                              }
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: getWidthPercentSize(context, 3)),
                            height: getScreenPercentSize(context, 7),
                            decoration: ShapeDecoration(
                              color: whiteColor,
                              shadows: [
                                BoxShadow(
                                    color: textColor.withOpacity(0.1),
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 4))
                              ],
                              shape: SmoothRectangleBorder(
                                borderRadius: SmoothBorderRadius(
                                  cornerRadius:
                                      getScreenPercentSize(context, 1.8),
                                  cornerSmoothing: 0.8,
                                ),
                              ),
                            ),
                            child: Center(
                              child: getTextWidget(
                                  (_position == 3) ? "Register" : "Next",
                                  textColor,
                                  getScreenPercentSize(context, 2),
                                  FontWeight.bold,
                                  TextAlign.center),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  _onPageViewChange(int page) {
    _position = page;
    setState(() {});
  }
}
