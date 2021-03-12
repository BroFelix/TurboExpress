import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/res/style.dart';

class CustomCheckBox extends StatelessWidget {
  final String label;
  final bool check;

  CustomCheckBox({this.label, @required this.check});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40.h,
          width: 40.w,
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: check ? Color(0xFF4CD964) : Colors.white,
              border: !check
                  ? Border.all(
                      color: Colors.black26,
                      width: 1.0,
                    )
                  : null),
          child: check
              ? Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 14.0,
                )
              : null,
        ),
        SizedBox(width: 24.w),
        Text(
          label,
          style: basicStyle1.copyWith(color: appGrey),
        ),
      ],
    );
  }
}
