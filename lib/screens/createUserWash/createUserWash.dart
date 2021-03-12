import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:turbo_express/res/style.dart';

import 'components/body.dart';

class CreateUserWashScreen extends StatefulWidget {
  @override
  _CreateUserWashScreenState createState() => _CreateUserWashScreenState();
}

class _CreateUserWashScreenState extends State<CreateUserWashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "createUserWash",
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
      body: CreateUserWashBody(),
    );
  }
}
