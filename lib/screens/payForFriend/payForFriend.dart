import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turbo_express/res/style.dart';
import 'package:turbo_express/screens/payForFriend/components/body.dart';

class PayForFriendScreen extends StatefulWidget {
  @override
  _PayForFriendScreenState createState() => _PayForFriendScreenState();
}

class _PayForFriendScreenState extends State<PayForFriendScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "payForFriendHeader",
          style: defaultStyle.copyWith(color: Colors.black),
        ).tr(),
      ),
      body: PayForFriendBody(),
    );
  }
}
