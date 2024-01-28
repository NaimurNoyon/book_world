import 'package:flutter/material.dart';
import 'package:book_world/SignInPage.dart';
import 'package:book_world/model/ProfileModel.dart';
import 'package:book_world/utils/Constant.dart';
import 'package:book_world/utils/CustomWidget.dart';
import 'package:book_world/utils/DataFile.dart';
import 'package:book_world/utils/PrefData.dart';
import 'package:book_world/utils/SizeConfig.dart';

import '../AboutUsPage.dart';
import '../AddToCartPage.dart';
import '../MyAdoptionPage.dart';
import '../MyOrderPage.dart';
import '../MySavedCardsPage.dart';
import '../NotificationList.dart';
import '../ProfilePage.dart';
import '../ShippingAddressPage.dart';
import '../WriteReviewPage.dart';



class ProfileWidget extends StatefulWidget {

  final Function function;
  ProfileWidget(this.function);



  @override
  _ProfileWidget createState() {
    return _ProfileWidget();
  }
}

class _ProfileWidget extends State<ProfileWidget>
    with SingleTickerProviderStateMixin {
  double padding = 0;
  double defMargin = 0;
  double height = 0;

  ProfileModel profileModel = DataFile.getProfileModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getThemeMode();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    padding = getScreenPercentSize(context, 2);
    defMargin = getHorizontalSpace(context);
    height = getScreenPercentSize(context, 5.5);

    Container divider=Container(
      margin: EdgeInsets.symmetric(vertical: (defMargin/1.5),horizontal: defMargin),
      height: getScreenPercentSize(context, 0.03),
      color: primaryColor.withOpacity(0.7),
    );

    return Container(
      width: double.infinity,
      color: backgroundColor,
      // padding: EdgeInsets.symmetric(horizontal:  defMargin),
      child: Column(
        children: [
          getAppBar(context, "More"),
          // Material(
          //   elevation: getScreenPercentSize(context,1.5),
          //   shadowColor: primaryColor.withOpacity(0.2),
          //   child: Container(
          //     width: double.infinity,
          //
          //     margin: EdgeInsets.symmetric(vertical: getScreenPercentSize(context, 2)),
          //
          //     child: getTextWithFontFamilyWidget("More", textColor, getScreenPercentSize(context, 3),
          //         FontWeight.w500, TextAlign.center),
          //
          //   ),
          // ),

          SizedBox(height: getScreenPercentSize(context, 1.5),),

          Expanded(
            child: ListView(
              children: [
                SizedBox(height: getScreenPercentSize(context, 1.5),),




                InkWell(
                  child: _getCell('editProfiles', Icons.edit),
                  onTap: () {
                    sendAction(ProfilePage());
                  },
                ),
                divider,
                InkWell(
                  child: _getCell('My Order', Icons.shopping_bag),
                  onTap: () {
                    sendAction(MyOrderPage(false));
                  },
                ),   divider,
                InkWell(
                  child: _getCell('Cart', Icons.shopping_cart),
                  onTap: () {
                    sendAction(AddToCartPage());
                  },
                ),   divider,
                InkWell(
                  child:
                  _getCell('address', Icons.local_shipping_outlined),
                  onTap: () {
                    sendAction(ShippingAddressPage());
                  },
                ),   divider,
                InkWell(
                  child: _getCell('mySavedCards', Icons.credit_card),
                  onTap: () {
                    sendAction(MySavedCardsPage());
                  },
                ),   divider,

                InkWell(
                  child: _getCell('My Adoption', Icons.credit_card,image: "pet.png"),
                  onTap: () {
                    sendAction(MyAdoptionPage());
                  },
                ),   divider,
                
                // InkWell(
                //   child: _getModeCell(
                //       'Night Mode',
                //       (!themMode)
                //           ? Icons.toggle_off_outlined
                //           : Icons.toggle_on_outlined),
                //   onTap: () {
                //     print("themeMode--1-$themMode}");
                //     if (themMode) {
                //       PrefData.setNightTheme(false);
                //     } else {
                //       PrefData.setNightTheme(true);
                //     }
                //     getThemeMode();
                //     widget.function();
                //   },
                // ),
                InkWell(
                  child:
                  _getCell('Notification', Icons.notifications_none),
                  onTap: () {
                    sendAction(NotificationList());
                  },
                ),   divider,
                InkWell(
                  child: _getCell('review', Icons.rate_review),
                  onTap: () {
                    sendAction(WriteReviewPage());
                  },
                ),   divider,
                InkWell(
                  child: _getCell('aboutUs', Icons.info),
                  onTap: () {
                    sendAction(AboutUsPage());
                  },
                ),

                SizedBox(height: getScreenPercentSize(context, 2),),
                getButtonWidget(context, 'logout', primaryColor, (){
                  PrefData.setIsSignIn(false);

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInPage(),
                      ));
                }),
                // InkWell(
                //   child: _getCell(S.of(context).logout, Icons.logout),
                //   onTap: () {
                //     PrefData.setIsSignIn(false);
                //
                //
                //
                //   },
                // ),
              ],
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
  bool themMode = false;

  void sendAction(StatefulWidget className) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => className));
  }


  getThemeMode() async {
    themMode = await PrefData.getNightTheme();
    setState(() {});
  }


  

  Widget _getCell(String s, var icon,{String? image}) {

    double size = getScreenPercentSize(context, 6);
    double iconSize = getPercentSize(size, 50);

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: defMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(
                right: getScreenPercentSize(context, 1)),
            height: size,
            width: size,
            decoration: new BoxDecoration(
                color: alphaColor,
                borderRadius: BorderRadius.all(Radius.circular(
                    getPercentSize(size, 15)))),
            child: (image!=null)?Center(child: Image.asset(assetsPath+image,height: iconSize,color: primaryColor,),):Icon(
              icon,
              size: iconSize,
              color: primaryColor,
            ),
          ),
          Text(
            s,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: getScreenPercentSize(context, 2),
              fontFamily: fontFamily,
              color: textColor,
            ),
          ),
          new Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 3),
              child: Image.asset(
                assetsPath+"right-chevron.png",
                color: textColor,
                height: getScreenPercentSize(context, 2),
              ),
            ),
          )
        ],
      ),
    );
  }





}
