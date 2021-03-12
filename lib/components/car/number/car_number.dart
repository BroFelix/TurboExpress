import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/res/style.dart';

class CarNumber extends StatelessWidget {
  final String label;
  final double height;
  final double fontSize;
  final double labelSize;
  final double countryLabelSize;
  final double iconSize;
  final StrutStyle strutStyle;

  CarNumber({
    this.label = "30|N951LA",
    this.height,
    this.fontSize,
    this.labelSize,
    this.countryLabelSize,
    this.iconSize,
    this.strutStyle,
  });

  @override
  Widget build(BuildContext context) {
    int charCode = label.codeUnitAt(3);
    String number = "";
    if (label != null) {
      if ("A".codeUnitAt(0) <= charCode && charCode <= "Z".codeUnitAt(0)) {
        number = StringUtils.addCharAtPosition(label, " ", 4);
        number = StringUtils.addCharAtPosition(number, " ", 8);
      } else {
        number = StringUtils.addCharAtPosition(label, ' ', 6);
      }
    }
    return Container(
      height: height ?? 90.h,
      padding: EdgeInsets.symmetric(horizontal: 2.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 3.0),
        borderRadius: BorderRadius.circular(7.5),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              label == "" || label == null ? "XX" : number.substring(0, label.length < 3 ? label.length : 2),
              style: carNumberStyle.copyWith(fontSize: labelSize ?? 48.ssp),
            )),
        VerticalDivider(
          color: Colors.black,
          width: 8.0,
          thickness: 2.0,
        ),
        SizedBox(width: 4.0),
        if (label != null && label.length > 0) ...[
          "A".codeUnitAt(0) <= charCode && charCode <= "Z".codeUnitAt(0)
              ? Text(
                  label.length <= 2 ? "A XXX AA" : number.substring(3, number.length),
                  style: carNumberStyle.copyWith(fontSize: fontSize ?? 64.h),
                  strutStyle: strutStyle,
                  textAlign: TextAlign.center,
                )
              : Text(
                  label.length <= 2 ? "XXX AAA" : number.substring(3, number.length),
                  style: carNumberStyle.copyWith(fontSize: fontSize ?? 64.h),
                  strutStyle: strutStyle,
                  textAlign: TextAlign.center,
                ),
        ] else ...[
          Text(
            "A XXX AA",
            style: carNumberStyle.copyWith(fontSize: fontSize ?? 64.h),
            strutStyle: strutStyle,
            textAlign: TextAlign.center,
          ),
        ],
        SizedBox(width: 8.0),
        Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 4.h,
                    horizontal: 8.w,
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/flag.svg',
                    height: iconSize ?? 16.h,
                    width: iconSize ?? 24.w,
                  )),
              SizedBox(
                  child: Text('UZ',
                      style: basicStyle1.copyWith(
                        color: skyBlue,
                        fontSize: countryLabelSize ?? 22.ssp,
                        fontWeight: FontWeight.bold,
                      ))),
            ]),
      ]),
    );
  }
}
