import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turbo_express/components/car/number/car_number.dart';
import 'package:turbo_express/res/style.dart';

class CarItemCard extends StatelessWidget {
  final bool check;
  final String carName;
  final String carNumber;

  CarItemCard({
    this.check = true,
    this.carName,
    this.carNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Colors.black, width: 2.0),
      ),
      height: 180.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SvgPicture.asset('assets/icons/sedan.svg', height: 32.h, width: 32.w),
                  ),
                  SizedBox(width: 24),
                  Text(carName, style: titleStyle.copyWith(fontWeight: FontWeight.w500)),
                ],
              ),
              Container(
                height: 24,
                width: 24,
                padding: EdgeInsets.all(4.h),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: check ? Colors.green : Colors.white,
                  border: !check ? Border.all(color: Colors.black, width: 1.0) : null,
                ),
                child: Icon(Icons.done, color: Colors.white, size: 18),
              ),
            ],
          ),
          CarNumber(label: carNumber),
        ],
      ),
    );
  }
}
