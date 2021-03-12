import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:turbo_express/common/constants.dart';
import 'package:turbo_express/common/functions/get_user.dart';
import 'package:turbo_express/common/functions/show_snackbar.dart';
import 'package:turbo_express/components/car/number/car_number_text_field.dart';
import 'package:turbo_express/model/order_in_progress.dart';
import 'package:turbo_express/model/user.dart';
import 'package:turbo_express/model/washing.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/res/style.dart';
import 'package:turbo_express/services/api/api.dart';

class PayForFriendBody extends StatefulWidget {
  @override
  _PayForFriendBodyState createState() => _PayForFriendBodyState();
}

class _PayForFriendBodyState extends State<PayForFriendBody> {
  List<Washing> washings = [];
  User _user;
  var _api = ApiService.getInstance();
  String _carLabel = "";
  int _selectedPackageId;
  int _selectedPackageIndex = 0;
  double _price = 0.0;
  double _balance = 0.0;
  double remainder = 0.0;
  bool _carType = false;
  int _userId;

  @override
  void initState() {
    var box = Hive.box(Constants.API_BOX);
    getUser().then((value) => _userId = value);
    washings = box.get("washings");
    _user = box.get("userInfo");
    super.initState();
  }

  String getTitle(BuildContext context, Washing washing) {
    if (context.locale == context.supportedLocales[0]) return washing.titleEn;
    if (context.locale == context.supportedLocales[1]) return washing.titleRu;
    if (context.locale == context.supportedLocales[2]) return washing.titleUz;
    return washing.titleRu;
  }

  @override
  Widget build(BuildContext context) {
    _balance = _user.balance.toDouble();
    final balanceMask = NumberFormat.currency(symbol: '', decimalDigits: _balance.toString().indexOf('.') == -1 ? 0 : 0)
        .format(num.parse(_balance.toString()));

    _selectedPackageId = washings[_selectedPackageIndex].id;
    _price = washings[_selectedPackageIndex].total.toDouble();
    remainder = _balance - _price;
    final priceMask = NumberFormat.currency(symbol: '', decimalDigits: _price.toString().indexOf('.') == -1 ? 0 : 0)
        .format(num.parse(_price.toString()));
    final remainderMask =
        NumberFormat.currency(symbol: '', decimalDigits: remainder.toString().indexOf('.') == -1 ? 0 : 0)
            .format(num.parse(remainder.toString()));

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Car label widget
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(color: Colors.grey.shade200, height: 250.h),
              Positioned(
                top: 0,
                child: Container(
                  padding: EdgeInsets.only(top: 24.h),
                  height: 140.h,
                  width: ScreenUtil().screenWidth,
                  color: skyBlue,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'physical',
                          style: basicStyle2.copyWith(color: Colors.white),
                        ).tr(),
                      ),
                      CupertinoSwitch(
                        trackColor: Colors.white,
                        onChanged: (bool value) {
                          setState(() {
                            _carType = value;
                          });
                        },
                        value: _carType,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'entity',
                          style: basicStyle2.copyWith(color: Colors.white),
                        ).tr(),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 15,
                child: CarNumberTextField(
                  entityType: _carType,
                  onSubmitted: (value) {
                    _carLabel = value;
                  },
                ),
              ),
            ],
          ),

          /// title for carousel
          Padding(
            padding: EdgeInsets.only(
              left: 34.w,
              top: 24.h,
              bottom: 12.h,
            ),
            child: Text(
              "chooseServicePackages",
              style: basicStyle2,
            ).tr(),
          ),

          /// Package carousel
          CarouselSlider.builder(
            itemCount: washings.length,
            itemBuilder: (context, i0, i1) {
              return Card(
                elevation: 2.0,
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(washings[i0].image),
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
                                  washings[i0].icon,
                                  height: 64.h,
                                  width: 64.w,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        getTitle(context, washings[i0]),
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
                initialPage: 0,
                height: 400.h,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  _selectedPackageId = washings[index].id;
                  setState(() {
                    _price = washings[index].total.toDouble();
                    remainder = _balance - _price;
                    _selectedPackageIndex = index;
                  });
                }),
          ),

          /// Balance - price
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 34.w),
            child: Row(
              children: [
                Card(
                  shape: CircleBorder(),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(12.h),
                    child: Icon(
                      Icons.money,
                      color: skyBlue,
                      size: 32,
                    ),
                  ),
                ),
                SizedBox(width: 24.w),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    "yourBalance",
                    style: basicStyle1,
                  ).tr(args: [":"]),
                  RichText(
                    text: TextSpan(
                      style: basicStyle2.copyWith(
                        color: Colors.black,
                      ),
                      text: "$balanceMask UZS",
                      children: [
                        TextSpan(text: " - "),
                        TextSpan(
                          text: "$priceMask UZS",
                          style: basicStyle2.copyWith(color: Colors.red),
                        ),
                      ],
                    ),
                  )
                ]),
              ],
            ),
          ),

          /// Remainder
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 34.w),
            child: Row(
              children: [
                Card(
                  shape: CircleBorder(),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(12.h),
                    child: Icon(
                      Icons.money,
                      color: skyBlue,
                      size: 32,
                    ),
                  ),
                ),
                SizedBox(width: 24.w),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    "balanceRemainder",
                    style: basicStyle1,
                  ).tr(args: [":"]),
                  Text(
                    "$remainderMask UZS",
                    style: basicStyle2,
                  ),
                ]),
              ],
            ),
          ),

          /// vertical space
          SizedBox(height: 36.h),

          /// Pay button
          Builder(
            builder: (context) => Align(
              alignment: Alignment.center,
              // ignore: deprecated_member_use
              child: OutlineButton(
                borderSide: BorderSide(
                  color: skyBlue,
                  width: 1.0,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 54.w,
                    vertical: 24.h,
                  ),
                  child: Text(
                    "pay",
                    style: basicStyle2.copyWith(color: skyBlue),
                  ).tr(),
                ),
                onPressed: () {
                  var newOrderInProgress = OrderInProgress(
                    status: 0,
                    user: _userId,
                    washingTemp: _selectedPackageId,
                    carNumber: _carLabel,
                    amount: _price,
                  );
                  _api.addOrderInProgress(newOrderInProgress).then((statusCode) {
                    if (statusCode == 200) {
                      showSnackBar(context, "Order successful");
                      Timer(const Duration(seconds: 1), () => ScaffoldMessenger.of(context).hideCurrentSnackBar());
                    } else {
                      showSnackBar(context, "error: $statusCode");
                      Timer(const Duration(seconds: 1), () => ScaffoldMessenger.of(context).hideCurrentSnackBar());
                    }
                  }, onError: (e) {
                    print(e.toString());
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
