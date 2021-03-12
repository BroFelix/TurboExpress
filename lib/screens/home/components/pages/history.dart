import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:turbo_express/common/constants.dart';
import 'package:turbo_express/components/card/history_card.dart';
import 'package:turbo_express/model/order.dart';
import 'package:turbo_express/model/washing.dart';
import 'package:turbo_express/res/style.dart';
import 'package:turbo_express/screens/home/components/home_drawer.dart';
import 'package:turbo_express/services/api/api.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  var api = ApiService.getInstance();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Order> finishedOrders = [];
  List<Washing> washings = [];

  @override
  void initState() {
    super.initState();
    var box = Hive.box(Constants.API_BOX);
    washings = box.get("washings");
    finishedOrders = box.get("orders");
    // finishedOrders.reversed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'historyHeader',
          style: basicStyle4.copyWith(color: Colors.black),
        ).tr(),
        // elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
      ),
      drawer: HomeDrawer(),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: finishedOrders != null && (finishedOrders ?? []).length != 0
            ? ListView.builder(
                padding: EdgeInsets.only(top: 12.h),
                itemCount: finishedOrders.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 4.h,
                    horizontal: 34.w,
                  ),
                  child: HistoryItem(order: finishedOrders[index]),
                ),
              )
            : Center(
                child: Text(
                  "Unfortunately you don't have\nany washing history yet!",
                  style: basicStyle2,
                  textAlign: TextAlign.center,
                ),
              ),
      ),
    );
  }
}
