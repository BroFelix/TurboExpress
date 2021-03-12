import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:turbo_express/components/car/number/car_number.dart';
import 'package:turbo_express/model/order.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/res/style.dart';

class HistoryItem extends StatelessWidget {
  final Order order;

  HistoryItem({this.order});

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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 36.h,
          horizontal: 34.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(FontAwesomeIcons.car),
                Text(
                  getDate(order.endTime) ?? "12.20.2012",
                  style: basicStyle3,
                ),
                CarNumber(
                  height: 64.h,
                  labelSize: 32.ssp,
                  fontSize: 42.ssp,
                ),
              ],
            ),
            Text(
               "Бесконтактная мойка",
              style: basicStyle3,
            ),
            SizedBox(height: 12.h),
            Text(
              "50 000 UZS",
              style: basicStyle5.copyWith(
                color: skyBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
