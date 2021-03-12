import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turbo_express/res/style.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          "about",
          style: basicStyle3.copyWith(color: Colors.black),
        ).tr(),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 166.h,
                            width: 166.w,
                            child: Image.asset('assets/icons/icon.png'),
                          ),
                          SizedBox(width: 48.w),
                          Text(
                            "TURBO EXPRESS",
                            style: basicStyle4,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                        "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. "
                        "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. "
                        "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
                        "'Content here, content here', making it look like readable English. "
                        "sometimes by accident, sometimes on purpose (injected humour and the like).",
                        style: basicStyle0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Разработчики проекта",
                    style: basicStyle1,
                  ),
                  Image.asset(
                    "assets/icons/ds.png",
                    height: 128.h,
                    width: 256.w,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
