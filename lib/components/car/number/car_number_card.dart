import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turbo_express/components/car/number/car_number.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/res/style.dart';

class CarNumberCard extends StatelessWidget {
  final String label;
  final String text;
  final String carType;

  CarNumberCard({
    @required this.label,
    this.text,
    this.carType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(12.h),
                  height: 96.h,
                  width: 96.w,
                  decoration: BoxDecoration(
                    color: darkBlue,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/sedan.svg',
                    color: Colors.white,
                    fit: BoxFit.contain,
                    height: 24.h,
                    width: 24.w,
                  ),
                ),
                SizedBox(width: 24.w),
                CarNumber(label: label),
              ],
            ),
            SizedBox(height: 16.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(text ?? "", style: basicStyle3, textAlign: TextAlign.left),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(carType,
                  style: basicStyle1.copyWith(
                    color: middleGrey,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.left),
            ),
          ],
        ),
      ),
    );
  }
}
