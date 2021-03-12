import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turbo_express/common/constants.dart';
import 'package:turbo_express/common/functions/save_logout.dart';
import 'package:turbo_express/model/user.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/res/style.dart';
import 'package:turbo_express/screens/onboarding/onboarding.dart';
import 'package:turbo_express/screens/settings/pages/about.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  User _user;

  // var _api = ApiService.getInstance();
  // bool _newsletter = false;
  // bool _phoneCalls = false;
  // bool _textMessages = false;
  // bool _specialAccess = false;
  bool _location = false;
  PickedFile _photo;
  final _picker = ImagePicker();

  @override
  void initState() {
    var box = Hive.box(Constants.API_BOX);
    _user = box.get("userInfo");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    String getLanguage() {
      if (locale == Locale('en', 'US')) return "English";
      if (locale == Locale('ru', 'RU')) return "Русский";
      if (locale == Locale('uz', 'UZ')) return "O'zbecha";
      return "Unknown language";
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "settingsHeader",
          style: basicStyle3.copyWith(
            color: Colors.black,
          ),
        ).tr(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 32.h),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Builder(
                    builder: (context) {
                      if (_user.avatar != null)
                        return Container(
                          height: 200.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(_user.avatar),
                            ),
                          ),
                        );
                      return Container(
                        height: 200.h,
                        width: 200.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                          image: DecorationImage(
                            image: Image.asset('assets/images/avatar_placeholder.png').image,
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    right: -25,
                    bottom: 0,
                    child: RawMaterialButton(
                      fillColor: Colors.white,
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
                      child: Icon(
                        Icons.edit_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: 8.w,
                ),
                child: Column(
                  children: [
                    Builder(
                      builder: (context) => ListTile(
                        onTap: () {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                              context: context,
                              builder: (BuildContext context) {
                                return FractionallySizedBox(
                                  heightFactor: 0.6,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 24.h),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 24.h),
                                          child: Text(
                                            "chooseLanguage",
                                            style: basicStyle4,
                                          ).tr(),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            context.locale = Locale('en', 'US');

                                            Navigator.pop(context);
                                            // App.restartApp(context);
                                          },
                                          title: Align(
                                            alignment: Alignment.center,
                                            child: Text("English"),
                                          ),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            context.locale = Locale('ru', 'RU');

                                            setState(() {});
                                            Navigator.pop(context);
                                            // App.restartApp(context);
                                          },
                                          title: Align(
                                            alignment: Alignment.center,
                                            child: Text("Русский"),
                                          ),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            context.locale = Locale('uz', 'UZ');

                                            setState(() {});
                                            Navigator.pop(context);
                                            // App.restartApp(context);
                                          },
                                          title: Align(
                                            alignment: Alignment.center,
                                            child: Text("O'zbekcha"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "interfaceLang",
                              style: basicStyle2,
                            ).tr(),
                            Text(
                              getLanguage(),
                              style: basicStyle0.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      // onTap: () {},
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "allowMyLocation",
                            style: basicStyle1,
                          ).tr(),
                          CupertinoSwitch(
                            activeColor: skyBlue,
                            onChanged: (bool value) {
                              setState(() {
                                _location = value;
                              });
                            },
                            value: _location,
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AboutScreen(),
                        ));
                      },
                      title: Text(
                        "about",
                        style: basicStyle2,
                      ).tr(),
                    ),
                    ListTile(
                      onTap: () async {
                        if (await canLaunch("tel: +998 90 602 47 95")) {
                          launch("tel: +998 90 602 47 95");
                        }
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "feedback",
                            style: basicStyle2,
                          ).tr(),
                          RawMaterialButton(
                            child: Row(
                              children: [
                                Icon(Icons.phone, color: skyBlue),
                                SizedBox(width: 24.w),
                                Text("call", style: basicStyle3.copyWith(color: skyBlue)).tr(),
                              ],
                            ),
                            onPressed: () async {
                              if (await canLaunch("tel: +998 90 602 47 95")) {
                                launch("tel: +998 90 602 47 95");
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 54.h),
          // ignore: deprecated_member_use
          OutlineButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
            padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 148.w),
            borderSide: BorderSide(color: Colors.black12, width: 1.0),
            onPressed: () {
              saveLogOut();

              Navigator.of(context).pushNamedAndRemoveUntil(OnBoarding.route, (r) => false);
            },
            child: Text(
              "exit",
              style: titleStyle,
            ).tr(),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: Text(
                  "Version 1.0",
                  style: basicStyle0.copyWith(fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
