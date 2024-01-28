import 'package:flutter/material.dart';
import 'package:book_world/utils/Constant.dart';
import 'package:book_world/utils/CustomWidget.dart';
import 'package:book_world/utils/DataFile.dart';
import 'package:book_world/utils/SizeConfig.dart';



class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPage createState() {
    return _AboutUsPage();
  }
}

class _AboutUsPage extends State<AboutUsPage> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    setThemePosition();

    double margin = getScreenPercentSize(context,1.5);


    return WillPopScope(
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: backgroundColor,

            toolbarHeight: 0,
            title: getAppBarText(context,'aboutUs'),

            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: getAppBarIcon(),
                  onPressed: _requestPop,
                );
              },
            ),
          ),
          body: Column(
            children: [
              getAppBar(context, 'aboutUs',function: (){
                _requestPop();
              }, isBack: true),
              Expanded(flex: 1,
                child: SingleChildScrollView(
                    child: Container(
                        margin: EdgeInsets.all(margin),



                        child: getSpaceTextWidget(loremText,

                            textColor,TextAlign.start, FontWeight.w400, getScreenPercentSize(context, 2)),


                    )),
              ),
            ],
          ),
        ),
        onWillPop: _requestPop);
  }
}
