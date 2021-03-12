import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:turbo_express/components/car/number/car_number.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/res/style.dart';

class PaymentCard extends StatelessWidget {
  final String createdDate;
  final String usedDate;
  final String washingItemTitle;
  final String carLabel;
  final int status;
  final String statusText;
  final double amount;

  PaymentCard({
    this.amount,
    this.createdDate,
    this.usedDate,
    this.carLabel,
    this.washingItemTitle,
    this.status,
    this.statusText,
  });

  @override
  Widget build(BuildContext context) {
    var moneyMask = NumberFormat.currency(symbol: '', decimalDigits: amount.toString().indexOf('.') == -1 ? 0 : 0)
        .format(num.parse(amount.toString()));
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: skyBlue),
                  child: Icon(FontAwesomeIcons.car, color: Colors.white),
                ),
                SizedBox(width: 24.w),
                CarNumber(label: carLabel),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
            child: Row(
              children: [
                Icon(FontAwesomeIcons.calendarCheck, color: skyBlue),
                SizedBox(width: 24.w),
                Text(
                  "washCreatedDate",
                  style: basicStyle0.copyWith(fontSize: 24.ssp),
                ).tr(args: [":"], namedArgs: {"date": createdDate}),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
            child: Row(
              children: [
                Icon(FontAwesomeIcons.handPointer, color: skyBlue),
                SizedBox(width: 24.w),
                Text(
                  "washType",
                  style: basicStyle0.copyWith(fontSize: 24.ssp),
                ).tr(args: [":"], namedArgs: {"type": washingItemTitle}),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
            child: Row(
              children: [
                Icon(FontAwesomeIcons.moneyBill, color: skyBlue),
                SizedBox(width: 24.w),
                Text(
                  "totalSum",
                  style: basicStyle0.copyWith(
                    fontSize: 24.ssp,
                    // color: skyBlue,
                  ),
                ).tr(args: [":"], namedArgs: {"sum": "$moneyMask UZS"}),
              ],
            ),
          ),
          Divider(color: Colors.black12, thickness: 2.0),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                status != 0
                    ? Row(
                        children: [
                          Icon(Icons.timer_off, color: skyBlue),
                          SizedBox(width: 24.w),
                          Text(
                            "washDate",
                            style: basicStyle0.copyWith(fontSize: 24.ssp),
                          ).tr(args: [":"], namedArgs: {"date": "$usedDate"}),
                        ],
                      )
                    : Container(),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                  color: status != 0 ? greenLight : Colors.grey,
                  // splashColor: Colors.greenAccent,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 56.w),
                    child: Text(
                      statusText,
                      style: basicStyle0.copyWith(color: Colors.white, fontSize: 24.ssp),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
