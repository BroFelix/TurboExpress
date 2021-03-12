import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:turbo_express/common/constants.dart';
import 'package:turbo_express/common/functions/get_token.dart';
import 'package:turbo_express/common/functions/get_user.dart';
import 'package:turbo_express/model/source.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/screens/home/home.dart';
import 'package:turbo_express/screens/onBoarding/onboarding.dart';
import 'package:turbo_express/services/api/api.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/splash';

  static Route routeBuilder() => MaterialPageRoute<void>(builder: (_) => SplashScreen());

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  // var _navKey = GlobalKey<NavigatorState>();
  // var _visible = true;
  AnimationController _animationController;
  Animation<double> _animation;
  var userId;
  var token;
  bool dataDownloadingComplete = false;
  var api = ApiService.getInstance();
  bool dataLoaded = false;

  @override
  void initState() {
    super.initState();
    getUser().then((value) => userId = value);
    getToken().then((value) => token = value);
    var box = Hive.box(Constants.API_BOX);
    api.getAllData().then((value) {
      Source source = value;
      box.put(Constants.Categories, source.category ?? null);
      box.put(Constants.Services, source.services ?? null);
      box.put(Constants.Washings, source.washings ?? null);
      box.put(Constants.CarTypes, source.carTypes ?? null);
      box.put(Constants.News, source.news ?? null);
      setState(() => dataLoaded = true);
    });

    // await api.getCars().then((value) => box.put("cars", value));
    _animationController = new AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = new CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
    _animation.addListener(() => this.setState(() {}));
    _animationController.forward();
    // setState(() => _visible = !_visible);
    // if (dataDownloadingComplete) startTime();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (dataLoaded) {
      Timer(const Duration(milliseconds: 500), () {
        if (userId != null && token != null)
          Navigator.of(context).popAndPushNamed(HomeScreen.route);
        else
          Navigator.of(context).popAndPushNamed(OnBoarding.route);
      });
    }
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: size.width,
        color: primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/icon.png',
              height: _animation.value * 256.h,
              width: _animation.value * 256.w,
            ),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
