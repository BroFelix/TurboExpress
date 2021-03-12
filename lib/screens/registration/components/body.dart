import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turbo_express/common/functions/show_snackbar.dart';

// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/res/style.dart';
import 'package:turbo_express/screens/login/login.dart';
import 'package:turbo_express/services/auth/auth.dart';
import 'package:turbo_express/utils/phone_number_formatter.dart';

import 'verification_page.dart';

class RegistrationBody extends StatefulWidget {
  @override
  _RegistrationBodyState createState() => _RegistrationBodyState();
}

class _RegistrationBodyState extends State<RegistrationBody> {
  var _formKey = GlobalKey<FormState>();
  var auth = AuthService();
  String name = '';
  String phone = '';
  String password = '';
  PickedFile _photo;
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  final _picker = ImagePicker();
  final _phoneMask = new PhoneNumberFormatter();
  var placeholder = Image.asset('assets/images/avatar_placeholder.png').image;

  // MaskTextInputFormatter(
  //   mask: '+998 (##) ###-##-##',
  //   filter: {'#': RegExp(r'[0-9]')},
  // );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  SizedBox(height: 84.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text('welcomeUser', style: headerStyle).tr(),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 24.h),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'signUpJoin',
                                style: basicStyle4.copyWith(
                                  fontSize: 32.ssp,
                                  color: appGrey,
                                ),
                              ).tr(),
                            ),
                          ],
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            FutureBuilder(
                              future: _photo != null ? _photo.readAsBytes() : Future.value(null),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var image = Image.memory(snapshot.data).image;
                                  return Container(
                                    height: 180.h,
                                    width: 180.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFC8C7CC),
                                      image: DecorationImage(image: image),
                                    ),
                                  );
                                }
                                return Container(
                                  height: 180.h,
                                  width: 180.w,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                      image: DecorationImage(
                                        image: placeholder,
                                      )),
                                );
                              },
                            ),
                            Positioned(
                              right: -20,
                              bottom: 0,
                              child: RawMaterialButton(
                                shape: CircleBorder(),
                                onPressed: () async {
                                  var imgSource;
                                  try {
                                    await showGeneralDialog(
                                      barrierColor: Colors.black.withOpacity(0.5),
                                      barrierDismissible: true,
                                      barrierLabel: '',
                                      context: context,
                                      transitionBuilder: (context, animation0, animation1, widget) {
                                        return Transform.scale(
                                          scale: animation0.value,
                                          child: Opacity(
                                            opacity: animation0.value,
                                            child: AlertDialog(
                                              shape: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(25.0),
                                              ),
                                              title: Text(
                                                "chooseSource",
                                                style: basicStyle3,
                                              ).tr(),
                                              content: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(Icons.camera, color: Colors.black),
                                                    onPressed: () {
                                                      imgSource = ImageSource.camera;
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: Icon(Icons.upload_file, color: Colors.black),
                                                    onPressed: () {
                                                      imgSource = ImageSource.gallery;
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      transitionDuration: const Duration(milliseconds: 200),
                                      pageBuilder: (context, animation0, animation1) {
                                        return Container();
                                      },
                                    );
                                    _photo = await _picker.getImage(source: imgSource);
                                    if (_photo != null) setState(() {});
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                },
                                fillColor: Colors.green,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameController,
                            onChanged: (value) {
                              name = value;
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'name'.tr(),
                              filled: true,
                              fillColor: Color(0xFFEFEFF4),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 14.h),
                          TextFormField(
                            controller: phoneController,
                            onChanged: (value) {
                              phone = value;
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              _phoneMask,
                              LengthLimitingTextInputFormatter(19),
                            ],
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'phone'.tr(),
                              filled: true,
                              fillColor: Color(0xFFEFEFF4),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 14.h),
                          TextFormField(
                            controller: passwordController,
                            onChanged: (value) {
                              password = value;
                            },
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'password'.tr(),
                              filled: true,
                              fillColor: Color(0xFFEFEFF4),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.w,
                    ),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      height: 100.h,
                      minWidth: double.infinity,
                      color: primaryColor,
                      textColor: Colors.white,
                      child: Text(
                        'signUp',
                        style: basicStyle2,
                      ).tr(),
                      onPressed: () {
                        auth
                            .register(
                          name: name,
                          phone: phone,
                          password: password,
                          language: context.locale,
                          imagePath: _photo != null ? _photo.path : "",
                        )
                            .then((response) {
                          if (response == 200) {
                            showSnackBar(context, 'regSuccess'.tr());
                            Timer(const Duration(seconds: 2), () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (_) => VerificationPage(phone: phone)));
                            });
                          } else
                            showSnackBar(context, 'regFailed'.tr() + response.toString());
                        }, onError: (error) {
                          // showSnackBar(context, error.toString());
                          showSnackBar(context, 'regFailed'.tr());
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
                            text: 'haveAccount'.tr(),
                            style: basicStyle2.copyWith(
                              fontSize: 26.ssp,
                              color: appGrey,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(text: ' '),
                              TextSpan(
                                text: 'signIn'.tr(),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.of(context).pushReplacement(
                                        LoginScreen.routeBuilder(),
                                      ),
                                style: basicStyle2.copyWith(
                                  fontSize: 26.ssp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
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
        );
      },
    );
  }
}
