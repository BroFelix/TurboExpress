import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turbo_express/common/functions/show_snackbar.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/res/style.dart';
import 'package:turbo_express/screens/forgot/verify.dart';
import 'package:turbo_express/services/auth/auth.dart';
import 'package:turbo_express/utils/phone_number_formatter.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const route = '/forgot';

  @override
  State<StatefulWidget> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String username;
  var phoneMask = PhoneNumberFormatter();
  var auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Forgot Password',
          style: defaultStyle.copyWith(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 32.h),
              child: Text(
                'Enter your phone number and we will send\n you instruction on how to reset it',
                style: basicStyle4,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 48.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: TextField(
                onChanged: (value) => username = value,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  phoneMask,
                  LengthLimitingTextInputFormatter(19),
                ],
                decoration: InputDecoration(
                  hintText: 'phone'.tr(),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                height: 100.h,
                minWidth: double.infinity,
                color: primaryColor,
                textColor: Colors.white,
                child: Text(
                  'send',
                  style: basicStyle3,
                ).tr(),
                onPressed: () {
                  auth.getVerifySMS(username: username).then((status) {
                    if (status == 200) {
                      showSnackBar(context, "Code has been sent!");
                      Timer(const Duration(seconds: 1), () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        return Navigator.of(context).popAndPushNamed(VerificationScreen.route, arguments: username);
                      });
                    } else {
                      showSnackBar(context, "Phone number not found!");
                      Timer(const Duration(seconds: 1), () => ScaffoldMessenger.of(context).hideCurrentSnackBar());

                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
