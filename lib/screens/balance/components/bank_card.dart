import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turbo_express/res/style.dart';

class BankCardWidget extends StatelessWidget {
  final String cardName;
  final String cardNumber;
  final String cardDate;
  final String cardOwner;

  BankCardWidget({
    @required this.cardName,
    @required this.cardNumber,
    @required this.cardDate,
    @required this.cardOwner,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: Image.asset('assets/images/card_bg.png').image,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/icons/uzcard.png",
                    height: 84.h,
                    width: 84.w,
                  ),
                  // Text("UZCARD", style: titleStyle),
                  Image.asset(
                    "assets/icons/icon.png",
                    height: 128.h,
                    width: 128.w,
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: Text(
                cardName,
                style: basicStyle4.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: Text(
                cardOwner,
                style: basicStyle5.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: Text(
                cardNumber,
                style: titleStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 128.w),
              child: Text(
                cardDate,
                style: titleStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
