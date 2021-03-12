import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/res/style.dart';

class CarType extends StatelessWidget {
  final String iconImage;
  final String carType;
  final price;
  final bool selected;

  CarType({
    @required this.iconImage,
    this.carType,
    this.price,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: selected ? skyBlue : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 36.h,
          horizontal: 12.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? Colors.white : skyBlue,
              ),
              padding: EdgeInsets.all(32.h),
              child: SvgPicture.network(
                iconImage,
                height: 24.h,
                width: 24.w,
                color: selected ? skyBlue : Colors.white,
              ),
            ),
            LimitedBox(
              maxWidth: 500.w,
              child: Text(
                carType,
                style: basicStyle3.copyWith(
                  color: selected ? Colors.white : Colors.black,
                ),
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
