import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turbo_express/common/functions/show_snackbar.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/res/style.dart';
import 'package:turbo_express/screens/login/login.dart';
import 'package:turbo_express/services/auth/auth.dart';

class VerificationScreen extends StatefulWidget {
  static const route = '/verify';
  final String phone;

  VerificationScreen({this.phone});

  @override
  State<StatefulWidget> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  var auth = AuthService();
  String smsCode;
  String password;
  String passwordAgain;

  // Timer _timer;
  // int _time = 100;

  var smsCodeController = TextEditingController();

  // void _startTimer() {
  //   const oneSec = const Duration(seconds: 1);
  //   _timer = new Timer.periodic(
  //     oneSec,
  //     (timer) {
  //       if (_time == 0) {
  //         setState(() => _timer.cancel());
  //       } else {
  //         setState(() => _time--);
  //       }
  //     },
  //   );
  // }

  @override
  void initState() {
    // _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    // _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phoneNumber = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'verifyNumber',
          style: defaultStyle.copyWith(color: Colors.black),
        ).tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 32.h),
            Text(
              "${'codeSent'.tr()}\n${widget.phone ?? phoneNumber}",
              style: basicStyle3,
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: TextField(
                controller: smsCodeController,
                inputFormatters: [LengthLimitingTextInputFormatter(4)],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'enterCode'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: TextField(
                onChanged: (value) => password = value,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: 'enterPassword'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: TextField(
                onChanged: (value) => passwordAgain = value,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: 'enterPassword'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 32.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                color: primaryColor,
                textColor: Colors.white,
                height: 100.h,
                minWidth: double.infinity,
                child: Text(
                  'verify',
                  style: basicStyle3,
                ).tr(),
                onPressed: () {
                  smsCode = smsCodeController.text;
                  if (password == passwordAgain &&
                      smsCode != null &&
                      smsCode != "" &&
                      password != null &&
                      passwordAgain != null) {
                    auth
                        .forgotPassword(
                      sms: smsCode,
                      username: phoneNumber,
                      password: passwordAgain,
                    )
                        .then((value) {
                      if (value == 200) {
                        showSnackBar(context, "Password changed!");
                        Timer(const Duration(seconds: 1), () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          Navigator.of(context).popAndPushNamed(LoginScreen.route);
                        });
                      } else {
                        showSnackBar(context, "Check if sms code right and password equal");
                        Timer(const Duration(seconds: 1), () => ScaffoldMessenger.of(context).hideCurrentSnackBar());
                      }
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
