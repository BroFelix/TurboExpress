import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/res/style.dart';

class ServiceCard extends StatefulWidget {
  final Key key;
  final String title;
  final String serviceDescription;
  final double price;
  final String imageUrl;
  final data;
  final Function(bool) onTap;
  final bool isSelected;

  ServiceCard({
    this.key,
    this.imageUrl = "https://placeholder.pics/svg/300x300",
    this.title = 'Newburgh Auto Spa',
    this.serviceDescription = 'Washing Service',
    this.price = 20000,
    this.data,
    this.onTap,
    this.isSelected = false,
  });

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  @override
  Widget build(BuildContext context) {
    bool selected = widget.isSelected;
    final priceMask =
    NumberFormat.currency(symbol: '', decimalDigits: widget.price.toString().indexOf('.') == -1 ? 0 : 0)
        .format(num.parse(widget.price.toString()));
    return widget.onTap != null ? GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
        if (selected) {
          widget.onTap.call(true);
        } else {
          widget.onTap.call(false);
        }
      },
      child: Card(
        color: selected ? skyBlue : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 24.w,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: selected ? Colors.white : skyBlue, width: 4.0),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.network(widget.imageUrl),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 16.h),
                height: 150.h,
                width: 150.w,
              ),
              SizedBox(width: 24.w),
              SizedBox(
                width: 400.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    Text(
                      widget.title,
                      style: titleStyle.copyWith(
                        fontSize: 32.ssp,
                        color: selected ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      widget.serviceDescription,
                      style: basicStyle1.copyWith(
                        fontWeight: FontWeight.normal,
                        color: selected ? Colors.white : textGreyColor,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "$priceMask UZS",
                      style: basicStyle5.copyWith(
                        color: selected ? Colors.white : skyBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ):Card(
      color: selected ? skyBlue : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 24.w,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: selected ? Colors.white : skyBlue, width: 4.0),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.network(widget.imageUrl),
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 16.h),
              height: 150.h,
              width: 150.w,
            ),
            SizedBox(width: 24.w),
            SizedBox(
              width: 400.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  Text(
                    widget.title,
                    style: titleStyle.copyWith(
                      fontSize: 32.ssp,
                      color: selected ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    widget.serviceDescription,
                    style: basicStyle1.copyWith(
                      fontWeight: FontWeight.normal,
                      color: selected ? Colors.white : textGreyColor,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "$priceMask UZS",
                    style: basicStyle5.copyWith(
                      color: selected ? Colors.white : skyBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
