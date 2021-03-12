import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:turbo_express/res/style.dart';
import 'package:turbo_express/screens/balance/components/body.dart';

class BalanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "replenishBalanceHeader",
          style: basicStyle3.copyWith(color: Colors.black),
        ).tr(),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BalanceBody(),
    );
  }
}
