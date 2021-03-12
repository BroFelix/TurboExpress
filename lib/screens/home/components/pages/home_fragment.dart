import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:turbo_express/common/constants.dart';
import 'package:turbo_express/model/news.dart';
import 'package:turbo_express/model/washing.dart';
import 'package:turbo_express/res/style.dart';
import 'package:turbo_express/screens/home/components/home_drawer.dart';
import 'package:turbo_express/screens/news/news.dart';
import 'package:turbo_express/services/api/api.dart';

class HomeFragment extends StatefulWidget {
  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  List<News> news = [];
  List<Washing> _washings = [];
  ApiService _api = ApiService.getInstance();

  final _refreshKey = new GlobalKey<RefreshIndicatorState>();

  void _fetchData() async {
    var apiBox = Hive.box(Constants.API_BOX);
    _washings = apiBox.get(Constants.Washings) ?? await _api.getWashings();
    news = apiBox.get(Constants.News) ?? await _api.getNews();
  }

  void _refreshData() {
    setState(() => _fetchData());
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    String getPackageTitle(Washing data) {
      if (locale == context.supportedLocales[0]) return data.titleEn;
      if (locale == context.supportedLocales[1]) return data.titleRu;
      if (locale == context.supportedLocales[2]) return data.titleUz;
      return data.titleRu;
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "TURBO EXPRESS",
          style: basicStyle3.copyWith(color: Colors.black),
        ),
      ),
      drawer: HomeDrawer(),
      body: RefreshIndicator(
        key: _refreshKey,
        onRefresh: () async {
          _refreshKey.currentState?.show(atTop: false);
          _refreshData();
          return null;
          // _refreshKey.currentState.
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider.builder(
                itemCount: 3,
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayAnimationDuration: const Duration(seconds: 2),
                  autoPlayCurve: Curves.easeInOut,
                  height: 400.h,
                  enableInfiniteScroll: true,
                ),
                itemBuilder: (BuildContext context, int index, int realIndex) => Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.all(12.h),
                      height: .25.sh,
                      width: ScreenUtil().screenWidth,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.asset('assets/images/home_bg.jpg').image,
                              ),
                            ),
                            foregroundDecoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.25),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 34.w,
                              right: 24.w,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "TURBO\nEXPRESS",
                                  style: basicStyle3.copyWith(
                                    color: Colors.white,
                                    fontSize: 54.ssp,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 24.h,
                                  ),
                                  child: SizedBox(
                                    width: 54.w,
                                    child: Divider(
                                      color: Colors.white,
                                      thickness: 4.h,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Комплексные услуги на мойку автомобилей",
                                  style: basicStyle2.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 36.ssp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 24.h,
                  horizontal: 34.w,
                ),
                child: Text(
                  'washingsAndServices',
                  style: basicStyle2.copyWith(fontSize: 32.ssp),
                ).tr(),
              ),
              CarouselSlider.builder(
                itemCount: _washings.length,
                itemBuilder: (context, i0, i1) {
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Stack(
                            fit: StackFit.loose,
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 42.h),
                                height: 230.h,
                                // width: ScreenUtil().screenWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(_washings[i0].image),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Card(
                                  shape: CircleBorder(),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.all(16.h),
                                    child: SvgPicture.network(
                                      _washings[i0].icon,
                                      height: 64.h,
                                      width: 64.w,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            getPackageTitle(_washings[i0]),
                            style: basicStyle3.copyWith(
                              fontSize: 38.ssp,
                            ),
                          ),
                          Text(
                            "от 20 минут",
                            style: basicStyle1.copyWith(color: Colors.grey, fontSize: 28.ssp),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 400.h,
                  enableInfiniteScroll: false,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 34.w,
                  top: 24.h,
                ),
                child: Text(
                  'news',
                  style: basicStyle3,
                ).tr(),
              ),
              Container(
                height: 300.h * news.length,
                width: ScreenUtil().screenWidth,
                margin: EdgeInsets.symmetric(
                  vertical: 24.h,
                  horizontal: 34.w,
                ),
                child: Column(
                  children: news.reversed
                      .take(3)
                      .map(
                        (e) => InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewsScreen(news: e)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: Image.network(e.image).image,
                              ),
                            ),
                            margin: EdgeInsets.symmetric(
                              vertical: 12.h,
                            ),
                            height: 350.h,
                            width: ScreenUtil().screenWidth,
                            child: Padding(
                              padding: EdgeInsets.only(left: 34.w, bottom: 34.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.titleRu,
                                    style: basicStyle1.copyWith(
                                      color: Colors.white,
                                      fontSize: 54.ssp,
                                    ),
                                  ),
                                  Text(
                                    e.shortRu,
                                    style: basicStyle1.copyWith(color: Colors.white, fontSize: 36.ssp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
