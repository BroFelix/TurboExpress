import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:turbo_express/common/constants.dart';
import 'package:turbo_express/common/functions/get_user.dart';
import 'package:turbo_express/common/functions/show_snackbar.dart';
import 'package:turbo_express/components/car/car_type.dart';
import 'package:turbo_express/components/car/number/car_number_text_field.dart';
import 'package:turbo_express/model/car.dart';
import 'package:turbo_express/model/car_type.dart' as model;
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/res/style.dart';
import 'package:turbo_express/services/api/api.dart';

class AddCarPage extends StatefulWidget {
  @override
  _AddCarPageState createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  List<bool> _selectedType = List.generate(4, (index) => false);
  List<model.CarType> _types = [];
  var _api = ApiService.getInstance();
  bool _entityType = false;
  int _carType;
  String _carLabel;
  String _carTitle;
  int _userId;

  @override
  void initState() {
    var box = Hive.box(Constants.API_BOX);
    getUser().then((value) => _userId = value);
    _types = box.get("carTypes");
    super.initState();
  }

  void _carTypeChanged(int index) {
    _selectedType.fillRange(0, 4, false);
    _carType = index + 1;
    setState(() => _selectedType[index] = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        centerTitle: true,
        title: Text('addCar', style: basicStyle4.copyWith(color: Colors.black)).tr(),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Car number typeSwitcher
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
                              _entityType = value;
                            });
                          },
                          value: _entityType,
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
                    entityType: _entityType,
                    onSubmitted: (value) {
                      _carLabel = value;
                    },
                  ),
                ),
              ],
            ),

            /// Some space
            SizedBox(height: 32.h),

            /// Car Label TextField
            Container(
              decoration: BoxDecoration(boxShadow: kElevationToShadow[16]),
              padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 24.h),
              child: TextField(
                onSubmitted: (value) {
                  _carTitle = value;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "carName".tr(),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),

            /// Title
            Padding(
              padding: EdgeInsets.symmetric(vertical: 48.h, horizontal: 34.w),
              child: Text("carTypeChoose", style: basicStyle3).tr(),
            ),

            /// Car Types Future
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int i = 0; i < _types.length; i++)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 4.h,
                      horizontal: 34.w,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        _carTypeChanged(i);
                      },
                      child: CarType(
                        iconImage: _types[i].image,
                        carType: _types[i].titleRu,
                        price: 10,
                        selected: _selectedType[i],
                      ),
                    ),
                  ),
              ],
            ),

            /// Some space
            SizedBox(height: 12.h),

            /// Add car wrapped with Builder
            /// Builder used to pass context to Scaffold
            Builder(
              builder: (context) => Align(
                alignment: Alignment.center,
                // ignore: deprecated_member_use
                child: OutlineButton(
                  padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 64.w),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                  borderSide: BorderSide(color: skyBlue, width: 1.0),
                  child: Text(
                    "addCar",
                    style: titleStyle.copyWith(color: skyBlue),
                  ).tr(),
                  onPressed: () async {
                    var car = Car(
                      user: _userId,
                      carType: _carType,
                      carNumber: _carLabel,
                      title: _carTitle,
                      status: 0,
                    );
                    _api.addCar(car: car).then((status) {
                      if (status == 201) {
                        showSnackBar(context, "Car added successfully");
                        Timer(const Duration(seconds: 2), () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          Navigator.pop(context);
                        });
                      } else {
                        showSnackBar(context, "request failed");
                        Timer(const Duration(seconds: 1), () => ScaffoldMessenger.of(context).hideCurrentSnackBar());
                      }
                    }, onError: (e) {
                      showSnackBar(context, e.toString());
                      Timer(const Duration(seconds: 1), () => ScaffoldMessenger.of(context).hideCurrentSnackBar());
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }
}
