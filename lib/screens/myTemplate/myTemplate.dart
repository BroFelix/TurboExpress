import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:turbo_express/common/constants.dart';
import 'package:turbo_express/components/card/template_card.dart';
import 'package:turbo_express/model/user_wash.dart';
import 'package:turbo_express/res/style.dart';
import 'package:turbo_express/services/api/api.dart';

class MyTemplatesScreen extends StatefulWidget {
  @override
  _MyTemplatesScreenState createState() => _MyTemplatesScreenState();
}

class _MyTemplatesScreenState extends State<MyTemplatesScreen> {
  List<UserWash> templates = [];
  var api = ApiService.getInstance();

  @override
  void initState() {
    var box = Hive.box(Constants.API_BOX);
    templates = box.get(Constants.UserWash);
    api.getUserWashes().then((value) {
      box.put(Constants.UserWash, value);
      templates = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "myTemplates",
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
      body: (templates ?? []).length > 0
          ? ListView.builder(
              // reverse: true,
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 34.w),
              itemCount: templates.length,
              itemBuilder: (context, index) => TemplateCard(userWash: templates[index]),
            )
          : Center(
              child: Text(
                "You don't have any template yet!",
                style: basicStyle4,
              ),
            ),
    );
  }
}
