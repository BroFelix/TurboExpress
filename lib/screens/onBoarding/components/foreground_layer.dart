import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/res/style.dart';
import 'package:turbo_express/screens/login/login.dart';
import 'package:turbo_express/screens/registration/registration.dart';
import 'package:url_launcher/url_launcher.dart';

class ForegroundLayer extends StatelessWidget {
  final Size size;
  final int currentPage;
  final VoidCallback skipPressed;
  final List<Widget> indicators;
  final Function(int) languageChanged;
  final String language;

  ForegroundLayer({
    @required this.size,
    @required this.currentPage,
    this.skipPressed,
    @required this.indicators,
    this.languageChanged,
    @required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          if (currentPage < 2)
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: skipPressed,
                child: Text(
                  'skip',
                  style: buttonTextStyle.copyWith(fontSize: 28.ssp),
                ).tr(),
              ),
            ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 32.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: indicators,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: currentPage == 0 ? true : false,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 32.w,
                vertical: 24.h,
              ),
              child: DropdownButtonFormField(
                icon: Icon(Icons.keyboard_arrow_down_outlined),
                iconEnabledColor: Colors.white,
                dropdownColor: primaryColor,
                decoration: InputDecoration(
                  isDense: true,
                  prefix: Container(
                    height: 24,
                    width: 24,
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                  hintStyle: defaultStyle.copyWith(color: Colors.white),
                  hintText: 'language'.tr(),
                  filled: true,
                  fillColor: primaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                  ),
                ),
                value: language,
                style: basicStyle0.copyWith(color: Colors.white),
                onChanged: (value) => languageChanged(value),
                items: [
                  DropdownMenuItem(
                    value: 0,
                    child: Text(
                      " English",
                      style: basicStyle1.copyWith(color: Colors.white),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 1,
                    child: Text(
                      " Русский",
                      style: basicStyle1.copyWith(color: Colors.white),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text(
                      " O'zbek",
                      style: basicStyle1.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonTheme(
                  height: 84.h,
                  minWidth: 250.w,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    color: primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).push(CupertinoPageRoute(builder: (context) => RegistrationScreen()));
//                          return _navKey.currentState.push(SignUp.routeBuilder());
                    },
                    child: Text(
                      'signUp',
                      style: buttonTextStyle.copyWith(fontSize: 28.ssp),
                    ).tr(),
                  ),
                ),
                ButtonTheme(
                  height: 84.h,
                  minWidth: 250.w,
                  child: OutlineButton(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'signIn',
                      style: buttonTextStyle.copyWith(fontSize: 28.ssp),
                    ).tr(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          Container(
            width: 500.w,
            child: RichText(
              strutStyle: StrutStyle(height: 2.2.h),
              textAlign: TextAlign.center,
              text: TextSpan(
                style: basicStyle0.copyWith(
                  color: Colors.white,
                ),
                text: 'byJoinAgree'.tr(),
                children: <TextSpan>[
                  TextSpan(
                    style: defaultStyle.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    text: 'termOfService'.tr(),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async => await canLaunch("https://mail.ru")
                          ? await launch("https://mail.ru")
                          : throw 'Could not launch',
                  ),
                  TextSpan(
                    text: 'and'.tr(),
                    style: defaultStyle.copyWith(color: Colors.white),
                  ),
                  TextSpan(
                    style: defaultStyle.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                    text: 'privacy'.tr(),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async => await canLaunch("https://mail.ru")
                          ? await launch("https://mail.ru")
                          : throw 'Could not launch',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 48.h),
        ],
      ),
    );
  }
}
