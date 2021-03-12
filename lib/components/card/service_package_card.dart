import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/res/style.dart';

class ServicePackage extends StatelessWidget {
  final bool selected;
  final String packageTitle;
  final double packagePrice;
  final int packageTime;

  ServicePackage({
    this.selected = false,
    this.packageTitle = 'Basic Hand Wash',
    this.packageTime = 30,
    this.packagePrice = 18.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical:12.h),
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: selected ? darkBlue : Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.black12, width: 1.0),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                packageTitle,
                style: basicStyle3.copyWith(color: selected ? Colors.white : Colors.black),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "\$$packagePrice",
                    style: basicStyle3.copyWith(color: selected ? Colors.white : Colors.black),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "$packageTime min",
                    style: basicStyle1.copyWith(color: selected ? Colors.white : Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '',
                    style: basicStyle1.copyWith(
                      fontWeight: FontWeight.normal,
                      color: selected ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    ' • Towel Dry • ',
                    style: basicStyle1.copyWith(
                      fontWeight: FontWeight.normal,
                      color: selected ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    'More',
                    style: basicStyle1.copyWith(
                      fontWeight: FontWeight.normal,
                      color: selected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            right: 10,
            child: Container(
              height: 24,
              width: 24,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: selected ? null : Border.all(color: Colors.black12, width: 1.0),
                color: selected ? Colors.green : Colors.white,
                shape: BoxShape.circle,
              ),
              child: selected
                  ? Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
