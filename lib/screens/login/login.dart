import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turbo_express/common/functions/show_snackbar.dart';

// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/res/style.dart';
import 'package:turbo_express/screens/forgot/forgot_password.dart';
import 'package:turbo_express/screens/home/home.dart';
import 'package:turbo_express/screens/login/components/check_box.dart';
import 'package:turbo_express/screens/registration/registration.dart';
import 'package:turbo_express/services/auth/auth.dart';
import 'package:turbo_express/utils/phone_number_formatter.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/signIn';

  static Route routeBuilder() {
    return MaterialPageRoute(builder: (_) => LoginScreen());
  }

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<StatefulWidget> {
  var _formKey = GlobalKey<FormState>();
  var _phoneMask = new PhoneNumberFormatter();

  // MaskTextInputFormatter(
  //   mask: '+998 (##) ###-##-##',
  //   filter: {'#': RegExp(r'[0-9]')},
  // );
  String _login;
  String _password;
  bool _remember = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraint) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  SizedBox(height: 128.h),
                  Container(
                    margin: EdgeInsets.only(left: 32.w),
                    alignment: Alignment.centerLeft,
                    child: Text('welcome', style: headerStyle).tr(),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 32.w, top: 16.h),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'signInToContinue',
                      style: basicStyle3.copyWith(color: appGrey),
                    ).tr(),
                  ),
                  SizedBox(height: 32.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            onChanged: (value) {
                              _login = value;
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              _phoneMask,
                              LengthLimitingTextInputFormatter(19),
                            ],
                            decoration: InputDecoration(
                              hintText: 'phone'.tr(),
                              isDense: true,
                              filled: true,
                              fillColor: Color(0xFFEFEFF4),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          TextFormField(
                            onChanged: (value) {
                              _password = value;
                            },
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: 'password'.tr(),
                              isDense: true,
                              filled: true,
                              fillColor: Color(0xFFEFEFF4),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() => _remember = !_remember);
                          },
                          child: CustomCheckBox(
                            check: _remember,
                            label: 'remember'.tr(),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                              style: basicStyle1.copyWith(color: Color(0xFF8A8A8F)),
                              text: 'forgotPassword'.tr(),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushNamed(ForgotPasswordScreen.route);
                                }),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      height: 100.h,
                      minWidth: double.infinity,
                      color: primaryColor,
                      textColor: Colors.white,
                      child: Text(
                        'signIn',
                        style: basicStyle2,
                      ).tr(),
                      onPressed: () {
                        AuthService().login(_login, _password).then((value) {
                          if (value == 200) {
                            showSnackBar(context, "logSuccess".tr());
                            Timer(const Duration(seconds: 2), () {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              Navigator.of(context).popAndPushNamed(HomeScreen.route);
                            });
                          } else {
                            showSnackBar(context, "logFailed".tr());
                            Timer(
                                const Duration(seconds: 1), () => ScaffoldMessenger.of(context).hideCurrentSnackBar());
                          }
                        }, onError: (error) {
                          // showSnackBar(context, error.toString());
                          showSnackBar(context, "logFailed".tr());
                          Timer(const Duration(seconds: 1), () => ScaffoldMessenger.of(context).hideCurrentSnackBar());
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 24.h),
                      alignment: FractionalOffset.bottomCenter,
                      child: RichText(
                        text: TextSpan(
                            style: basicStyle1.copyWith(
                              color: appGrey,
                              fontWeight: FontWeight.w500,
                            ),
                            text: 'dontHaveAccount'.tr(),
                            children: [
                              TextSpan(text: ' '),
                              TextSpan(
                                style: basicStyle1.copyWith(color: Colors.black),
                                text: 'signUp'.tr(),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.of(context).pushReplacement(
                                        RegistrationScreen.routeBuilder(),
                                      ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
