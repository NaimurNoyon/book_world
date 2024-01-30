import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:book_world/AddToCartPage.dart';
import 'package:book_world/tabWidget/HomeWidget.dart';
import 'package:book_world/tabWidget/ProfileWidget.dart';
import 'package:book_world/tabWidget/SearchWidget.dart';
import 'package:book_world/utils/Constant.dart';
import 'package:book_world/utils/CustomWidget.dart';
import 'AllPetPage.dart';
import 'customView/CustomAnimatedBottomBar.dart';
import 'main.dart';

class MainPage extends StatefulWidget {

  final int? tabPosition;
  const MainPage({super.key, this.tabPosition});


  @override
  _MainPage createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> {
  int _currentIndex = 0;


  Future<bool> _requestPop() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex = 0;
      });
    } else {
      exitApp();
    }
    return Future.value(false);
  }

  Widget getBody() {
    List<Widget> pages = [
      HomeWidget((){
        setState(() {
          _currentIndex=3;
        });
      },functionViewAll: (){
        setState(() {
          _currentIndex=1;
        });
      },functionAdoptionAll: (){
        setState(() {
          _currentIndex=3;
        });
      }),
      SearchWidget(),

      AddToCartPage(function: (){
        _requestPop();
      }),

      AllPetPage(function: (){
        _requestPop();
      }),

      ProfileWidget((){
        myTheme.switchTheme();

        Future.delayed(const Duration(seconds:  1), () {
          setThemePosition(context: context);
          setState(() {});
        });
      }),


    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }

  @override
  void initState() {
    super.initState();
    if(widget.tabPosition!=null){
      setState(() {
        _currentIndex = widget.tabPosition!;
      });
    }
    Future.delayed(const Duration(seconds: 0), () {
      setThemePosition(context: context);
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 0,
            backgroundColor: secondaryColor,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: secondaryColor,
              statusBarIconBrightness: Brightness.dark,
              // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
          ),

          resizeToAvoidBottomInset: true,
          backgroundColor: secondaryColor,
          bottomNavigationBar: _buildBottomBar(),
          body: SafeArea(
            child: Container(
                child: getBody()),
          ),
        ));
  }

  Widget _buildBottomBar() {
    final inactiveColor = iconColor;
    final activeColor = primaryColor;

    double height = getScreenPercentSize(context, 7.5);
    double iconHeight = getPercentSize(height, 28);
    return CustomAnimatedBottomBar(
      containerHeight: height,
      backgroundColor: secondaryColor,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[

        BottomNavyBarItem(
          title: 'Home',
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          textAlign: TextAlign.center,
          iconSize: iconHeight,
          imageName: "home bold.png",
        ),

        BottomNavyBarItem(
          title: 'Search',
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          textAlign: TextAlign.center,
          iconSize: iconHeight,
          imageName: "search.png",
        ),



        BottomNavyBarItem(
          title: 'Cart',
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          textAlign: TextAlign.center,
          iconSize: iconHeight,
          imageName: "orders.png",
        ),

        BottomNavyBarItem(
          title: 'All Pets',
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          textAlign: TextAlign.center,
          iconSize: iconHeight,
          imageName: "pet.png",
        ),





        BottomNavyBarItem(
          iconSize: iconHeight,
          title: 'Profile',
          activeColor: activeColor,
          imageName: "more.png",
          inactiveColor: inactiveColor,
          textAlign: TextAlign.center
        ),
      ],
    );
  }
}
