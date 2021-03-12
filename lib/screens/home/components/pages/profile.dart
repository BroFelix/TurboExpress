import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:turbo_express/common/constants.dart';
import 'package:turbo_express/components/car/number/car_number_card.dart';
import 'package:turbo_express/model/car.dart';
import 'package:turbo_express/model/car_type.dart';
import 'package:turbo_express/model/user.dart';
import 'package:turbo_express/model/user_card.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/res/style.dart';
import 'package:turbo_express/screens/home/components/home_drawer.dart';
import 'package:turbo_express/screens/home/components/pages/add_car.dart';
import 'package:turbo_express/services/api/api.dart';

class ProfileScreen extends StatefulWidget {
  static const route = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<CarType> carTypes = [];
  List<Car> cars = [];
  User user;
  List<UserCard> userCards = [];
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  ApiService _api = ApiService.getInstance();
  var box = Hive.box(Constants.API_BOX);

  // int userId;

  @override
  void initState() {
    user = box.get(Constants.UserInfo);
    userCards = box.get(Constants.UserCards);
    carTypes = box.get(Constants.CarTypes);
    cars = box.get(Constants.Cars);
    _api.getCars().then((value) {
      if (value != cars) {
        box.put("cars", value);
        setState(() => cars = value);
      }
    });
    super.initState();
  }

  String getDate(DateTime date) {
    String result = date.day.toString() +
        "." +
        (date.month < 10 ? ("0" + date.month.toString()) : date.month.toString()) +
        "." +
        date.year.toString();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'profileHeader',
          style: basicStyle3.copyWith(color: Colors.black),
        ).tr(),
      ),
      drawer: HomeDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Builder(builder: (context) {
              int balance = user.balance;
              return Stack(
                children: [
                  Container(
                    height: 400.h,
                    width: ScreenUtil().screenWidth,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/account_bg.jpg'),
                      ),
                    ),
                    foregroundDecoration: BoxDecoration(color: Colors.black.withOpacity(0.35)),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 24.h,
                          horizontal: 34.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ID ${user.id}",
                                  style: basicStyle3.copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                                user.avatar != null
                                    ? Container(
                                        height: 200.h,
                                        width: 200.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(user.avatar),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 200.h,
                                        width: 200.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: Image.asset('assets/images/avatar_placeholder.png').image,
                                          ),
                                        ),
                                      ),
                                Text(
                                  user.fullname,
                                  style: basicStyle3.copyWith(color: Colors.white),
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  user.username,
                                  style: basicStyle3.copyWith(color: Colors.white, fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                            Builder(
                              builder: (context) {
                                final moneyMask = NumberFormat.currency(
                                        symbol: '', decimalDigits: balance.toString().indexOf('.') == -1 ? 0 : 0)
                                    .format(num.parse(balance.toString()));
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.local_atm,
                                            color: skyBlue,
                                            size: 36,
                                          ),
                                        ),
                                        SizedBox(height: 12.h),
                                        Text(
                                          "$moneyMask UZS",
                                          style: basicStyle2.copyWith(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 24.h),
                                    Builder(
                                      builder: (context) {
                                        var card = userCards.firstWhere((element) {
                                          return element.user == user.id;
                                        }, orElse: () {
                                          return null;
                                        });
                                        if (card != null)
                                          return Column(
                                            children: [
                                              Container(
                                                // height: 96.h,
                                                // width: 96.w,
                                                padding: EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.credit_card_rounded,
                                                  color: skyBlue,
                                                  size: 32,
                                                ),
                                              ),
                                              SizedBox(height: 12.h),
                                              Text(
                                                "${card.cardType}\n${getDate(card.endDate)}",
                                                style: basicStyle2.copyWith(color: Colors.white),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          );
                                        else
                                          return Container();
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 12.h, left: 34.w, right: 34.w),
              child: Text('myCar', style: titleStyle.copyWith(fontWeight: FontWeight.w500)).tr(),
            ),
            Builder(
              builder: (context) {
                if (cars != null && (cars ?? []).length != 0)
                  return SizedBox(
                    height: 260.h,
                    width: ScreenUtil().screenWidth,
                    child: ListView.builder(
                      itemCount: cars.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 30.w),
                        child: Builder(
                          builder: (context) {
                            int carTypeIndex = cars[index].carType - 1;
                            CarType type = carTypes[carTypeIndex];
                            return CarNumberCard(
                              label: cars[index].carNumber,
                              text: cars[index].title,
                              carType: type.titleRu,
                            );
                          },
                        ),
                      ),
                    ),
                  );
                else
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "You don't have any car yet!",
                        style: basicStyle3,
                      ),
                    ),
                  );
              },
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
              // ignore: deprecated_member_use
              child: OutlineButton(
                borderSide: BorderSide(color: darkBlue, width: 1.0),
                padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 72.w),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                child: Text('addCar', style: titleStyle.copyWith(color: darkBlue)).tr(),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddCarPage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
