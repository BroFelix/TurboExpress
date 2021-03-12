import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turbo_express/model/news.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/res/style.dart';

class NewsScreen extends StatefulWidget {
  final News news;

  NewsScreen({@required this.news});

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  String getDateTime() {
    DateTime compareDate = widget.news.created;
    DateTime currentDate = DateTime.now();
    int yesterday = currentDate.day - 1;
    String result = "";
    if (currentDate.day == compareDate.day) {
      result += ("today".tr());
    } else if (yesterday == compareDate.day) {
      result += ("yesterday".tr());
    } else {
      result += compareDate.day.toString();
      result += ", ";
      switch (compareDate.month) {
        case DateTime.january:
          result += ("january".tr());
          break;
        case DateTime.february:
          result += ("february".tr());
          break;
        case DateTime.march:
          result += ("march".tr());
          break;
        case DateTime.april:
          result += ("april".tr());
          break;
        case DateTime.may:
          result += ("may".tr());
          break;
        case DateTime.june:
          result += ("june".tr());
          break;
        case DateTime.july:
          result += ("july".tr());
          break;
        case DateTime.august:
          result += ("august".tr());
          break;
        case DateTime.september:
          result += ("september".tr());
          break;
        case DateTime.october:
          result += ("october".tr());
          break;
        case DateTime.november:
          result += ("november".tr());
          break;
        case DateTime.december:
          result += ("december".tr());
          break;
        default:
          result += "Unknown month";
          break;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    String getTitle() {
      if (locale == context.supportedLocales[0]) return widget.news.titleEn;
      if (locale == context.supportedLocales[1]) return widget.news.titleRu;
      if (locale == context.supportedLocales[2]) return widget.news.titleUz;
      return widget.news.titleRu;
    }

    String getContent() {
      if (locale == context.supportedLocales[0]) return widget.news.contentEn;
      if (locale == context.supportedLocales[1]) return widget.news.contentRu;
      if (locale == context.supportedLocales[2]) return widget.news.contentUz;
      return widget.news.contentRu;
    }

    String getCategory() {
      if (locale == context.supportedLocales[0]) return widget.news.categoryEn;
      if (locale == context.supportedLocales[1]) return widget.news.categoryRu;
      if (locale == context.supportedLocales[2]) return widget.news.categoryUz;
      return widget.news.categoryRu;
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "news",
          style: basicStyle5.copyWith(
            color: Colors.black,
            fontSize: 36.ssp,
          ),
        ).tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LimitedBox(
              maxHeight: 500.h,
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    top: 0,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          height: 200.h,
                          width: ScreenUtil().screenWidth,
                          decoration: BoxDecoration(color: skyBlue),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 34.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getTitle(),
                                style: basicStyle2.copyWith(
                                  color: Colors.white,
                                  fontSize: 46.ssp,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                "${getDateTime()}  /  ${getCategory()}",
                                style: basicStyle1.copyWith(
                                  color: Colors.white,
                                  fontSize: 32.ssp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    child: Container(
                      height: 300.h,
                      width: 650.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: Image.network(widget.news.image).image,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 34.w),
              child: Text(
                getContent(),
                style: basicStyle0.copyWith(
                  color: Colors.black,
                  fontSize: 26.ssp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
