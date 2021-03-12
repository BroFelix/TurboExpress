import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:turbo_express/model/user_wash.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/res/style.dart';

class TemplateCard extends StatefulWidget {
  final UserWash userWash;

  TemplateCard({@required this.userWash});

  @override
  _TemplateCardState createState() => _TemplateCardState();
}

class _TemplateCardState extends State<TemplateCard> {
  bool _defaultValue;

  @override
  void initState() {
    _defaultValue = widget.userWash.isDefault;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 24.h,
          horizontal: 34.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: skyBlue, width: 2.0),
                  ),
                  child: Icon(
                    FontAwesomeIcons.car,
                    color: skyBlue,
                  ),
                ),
                SizedBox(width: 36.w),
                Text(
                  widget.userWash.title,
                  style: basicStyle2,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Text(
                "Дополнительные услуги",
                style: basicStyle1,
              ),
            ),
            LimitedBox(
              maxHeight: 100.h,
              maxWidth: 400.w,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.userWash.userWashItem.length,
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.userWash.userWashItem[index].userWash.toString()),
                    Text("${widget.userWash.userWashItem[index].amount} UZS"),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: skyBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.money,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "${widget.userWash.user} UZS",
                  style: basicStyle4.copyWith(color: skyBlue),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Шаблон по умолчанию",
                        style: basicStyle1,
                      ),
                      Text(
                        _defaultValue ? "Включен" : "Отключен",
                        style: basicStyle0,
                      )
                    ],
                  ),
                  CupertinoSwitch(
                    activeColor: skyBlue,
                    value: _defaultValue,
                    onChanged: (bool value) {
                      setState(() {
                        _defaultValue = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
