import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:turbo_express/common/constants.dart';
import 'package:turbo_express/components/card/payment_card.dart';
import 'package:turbo_express/model/order_in_progress.dart';
import 'package:turbo_express/model/washing.dart';
import 'package:turbo_express/res/style.dart';
import 'package:turbo_express/services/api/api.dart';

class ListOfFriendPaymentScreen extends StatefulWidget {
  @override
  _ListOfFriendPaymentScreenState createState() => _ListOfFriendPaymentScreenState();
}

class _ListOfFriendPaymentScreenState extends State<ListOfFriendPaymentScreen> {
  List<OrderInProgress> orders = [];
  List<Washing> washings = [];
  var api = ApiService.getInstance();

  @override
  void initState() {
    var box = Hive.box(Constants.API_BOX);
    orders = box.get(Constants.OrderInProgress);
    washings = box.get(Constants.Washings);
    api.getOrdersInProgress().then((value) {
      box.put(Constants.OrderInProgress, value);
      orders = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    String getWashingItemTitle(int id, List<Washing> washings) {
      Washing temp;
      washings.forEach((element) {
        if (element.id == id) temp = element;
      });
      if (temp != null) {
        if (locale == context.supportedLocales[0]) return temp.titleEn;
        if (locale == context.supportedLocales[1]) return temp.titleRu;
        if (locale == context.supportedLocales[2]) return temp.titleUz;
        return "not found";
      }
      return "this is null";
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "listOfPaymentsForFriendsHeader",
          style: basicStyle3.copyWith(
            color: Colors.black,
          ),
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
      body: (orders ?? []).length > 0
          ? ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 34.w),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return PaymentCard(
                  amount: orders[index].amount,
                  createdDate:
                      "${orders[index].created.year}.${orders[index].created.month}.${orders[index].created.day}",
                  usedDate: orders[index].usedDate ?? "",
                  carLabel: orders[index].carNumber,
                  washingItemTitle:
                      getWashingItemTitle(orders[index].washingTemp ?? 1, washings ?? []) ?? "Function is null",
                  status: 0,
                  statusText: orders[index].status == 0 ? "pending".tr() : "success".tr(),
                );
              },
            )
          : Center(
              child: Text(
                "You don't have any orders in progress",
                style: basicStyle4,
              ),
            ),
    );
  }
}
