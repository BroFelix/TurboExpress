import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turbo_express/res/color.dart';

class AddCard extends StatelessWidget {
  final Function onTap;

  AddCard({@required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        color: skyBlue,
        child: Container(
          margin: EdgeInsets.all(24.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(color: Colors.white, width: 2.0),
          ),
          // height: 300.h,
          width: ScreenUtil().screenWidth,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                Icons.add,
                color: skyBlue,
                size: 64.h,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
