import 'package:flutter/material.dart';
import 'package:book_world/utils/Constant.dart';
import 'package:book_world/utils/CustomDialogBox.dart';
import 'package:book_world/utils/CustomWidget.dart';
import 'package:book_world/utils/SizeConfig.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'ResetPasswordPage.dart';
import 'SignInPage.dart';

class PhoneVerification extends StatefulWidget {
  final bool isSignUp;

  PhoneVerification(this.isSignUp);

  @override
  _PhoneVerification createState() {
    return _PhoneVerification();
  }
}

class _PhoneVerification extends State<PhoneVerification> {
  bool isRemember = false;
  int themeMode = 0;
  TextEditingController textEmailController = new TextEditingController();
  TextEditingController textPasswordController = new TextEditingController();

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  final GlobalKey<FormFieldState<String>> _formKey =
      GlobalKey<FormFieldState<String>>(debugLabel: '_formKey');
  TextEditingController _pinEditingController =
      TextEditingController(text: '123');
  bool _enable = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 0), () {
      setThemePosition(context: context);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ColorBuilder _solidColor = PinListenColorBuilder(cellColor, cellColor);

    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          backgroundColor: secondaryColor,
          appBar: AppBar(
            backgroundColor: secondaryColor,
            elevation: 0,
            title: Text(""),
            leading: GestureDetector(
              onTap: () {
                _requestPop();
              },
              child: Icon(
                Icons.keyboard_backspace,
                color: textColor,
              ),
            ),
          ),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(getHorizontalSpace(context)),
              child: ListView(
                children: [
                  SizedBox(
                    height: getScreenPercentSize(context, 3),
                  ),
                  getTextWithFontFamilyWidget(
                    "Verify",
                    textColor,
                    getScreenPercentSize(context, 3),
                    FontWeight.w400,
                    TextAlign.left,
                  ),
                  SizedBox(
                    height: getScreenPercentSize(context, 0.7),
                  ),
                  getTextWidget(
                    "Enter code send to your mobile number",
                    textColor,
                    getScreenPercentSize(context, 1.9),
                    FontWeight.w400,
                    TextAlign.left,
                  ),
                  SizedBox(
                    height: getScreenPercentSize(context, 5),
                  ),
                  Center(
                    child: SizedBox(
                      width: SizeConfig.safeBlockHorizontal! * 70,
                      child: PinInputTextFormField(
                        key: _formKey,
                        pinLength: 4,
                        decoration: BoxLooseDecoration(
                          bgColorBuilder: _solidColor,
                          strokeWidth: 0.5,
                          textStyle: TextStyle(
                              color: textColor,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          strokeColorBuilder: PinListenColorBuilder(
                            subTextColor,
                            subTextColor,
                          ),
                          obscureStyle: ObscureStyle(
                            isTextObscure: false,
                            obscureText: '🤪',
                          ),
                        ),
                        controller: _pinEditingController,
                        textInputAction: TextInputAction.go,
                        enabled: _enable,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.characters,
                        onSubmit: (pin) {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                          }
                        },
                        onChanged: (pin) {
                          setState(() {
                            debugPrint('onChanged execute. pin:$pin');
                          });
                        },
                        onSaved: (pin) {
                          debugPrint('onSaved pin:$pin');
                        },
                        validator: (pin) {
                          if (pin!.isEmpty) {
                            setState(() {});
                            return 'Pin cannot empty.';
                          }
                          setState(() {});
                          return null;
                        },
                        cursor: Cursor(
                          width: 2,
                          color: primaryColor,
                          radius: Radius.circular(1),
                          enabled: true,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 5,
                  ),
                  Container(
                    child: Column(
                      children: [
                        getButtonWithoutSpaceWidget(
                            context, "Next", primaryColor, () {
                          if (widget.isSignUp) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialogBox(
                                    title: "Account Created!",
                                    descriptions:
                                        "Your account has\nbeen successfully created!",
                                    text: "Continue",
                                    func: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SignInPage(),
                                          ));
                                    },
                                  );
                                });
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResetPasswordPage(),
                                ));
                          }
                        }),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 3,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom: getScreenPercentSize(context, 2)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                getTextWidget(
                                    "Didn't receive code?",
                                    textColor,
                                    getScreenPercentSize(context, 2),
                                    FontWeight.w600,
                                    TextAlign.center),
                                SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  child: getTextWidget(
                                      "Resend",
                                      primaryColor,
                                      getScreenPercentSize(context, 2),
                                      FontWeight.w700,
                                      TextAlign.center),
                                  onTap: () {},
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
