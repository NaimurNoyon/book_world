import 'package:flutter/material.dart';
import 'package:book_world/utils/Constant.dart';
import 'package:book_world/utils/CustomWidget.dart';
import 'package:book_world/utils/SizeConfig.dart';

import 'PhoneVerification.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPage createState() {
    return _ForgotPasswordPage();
  }
}

class _ForgotPasswordPage extends State<ForgotPasswordPage> {
  int themeMode = 0;
  TextEditingController phoneController = new TextEditingController();
  String countryCode = "IN";

  Future<bool> _requestPop() {
    Navigator.of(context).pop();

    return new Future.value(false);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0), () {
      setThemePosition(context: context);
      setState(() {});
    });
  }

  TextEditingController textNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          backgroundColor: secondaryColor,
          appBar: AppBar(
            backgroundColor: secondaryColor,
            elevation: 0,
            title: Text(""),
            leading: InkWell(
              child: Icon(
                Icons.keyboard_backspace,
                color: textColor,
              ),
              onTap: _requestPop,
            ),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(
                horizontal: getHorizontalSpace(context)),
            child: ListView(
              children: [


                SizedBox(
                  height: getScreenPercentSize(context, 3),
                ),


                getTextWithFontFamilyWidget(
                  "Forgot Password",
                  textColor,
                  getScreenPercentSize(context, 3),
                  FontWeight.w400,
                  TextAlign.left,
                ),



                SizedBox(
                  height: getScreenPercentSize(context, 0.7),
                ),

                getTextWidget(
                  "We need your registration email to send you password reset code!",
                  textColor,
                  getScreenPercentSize(context, 1.9),
                  FontWeight.w400,
                  TextAlign.left,
                ),

                // getTextWidget(
                //   "Forgot Password",
                //   textColor,
                //   getScreenPercentSize(context, 4),
                //   FontWeight.bold,
                //   TextAlign.left,
                // ),
                // SizedBox(
                //   height: getScreenPercentSize(context, 0.5),
                // ),
                // getTextWidget(
                //   "We need your registration email to send you password reset code!",
                //   subTextColor,
                //   getScreenPercentSize(context, 1.8),
                //   FontWeight.w400,
                //   TextAlign.start,
                // ),
                SizedBox(
                  height: getScreenPercentSize(context, 3),
                ),
                getDefaultTextFiledWidget(context, "Your Email",
                    Icons.account_circle_outlined, textNameController),
                SizedBox(
                  height: getScreenPercentSize(context, 2),
                ),
                getButtonWithoutSpaceWidget(context, "Next", primaryColor, () {
                  sendPage();
                }),
              ],
            ),
          ),
        ));
  }

  void sendPage() {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhoneVerification(false),
        ));
  }
}
