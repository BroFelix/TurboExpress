import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:turbo_express/common/constants.dart';
import 'package:turbo_express/common/functions/get_user.dart';
import 'package:turbo_express/common/functions/show_snackbar.dart';
import 'package:turbo_express/model/bank_card.dart';
import 'package:turbo_express/model/user.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/res/style.dart';
import 'package:turbo_express/screens/balance/components/bank_card.dart';
import 'package:turbo_express/services/api/api.dart';
import 'package:turbo_express/utils/currency_formatter.dart';

import 'add_card.dart';
import 'card_form.dart';

class BalanceBody extends StatefulWidget {
  @override
  _BalanceBodyState createState() => _BalanceBodyState();
}

class _BalanceBodyState extends State<BalanceBody> {
  var box = Hive.box(Constants.API_BOX);

  // var _userKey = GlobalKey();
  User user;
  List<BankCard> bankCards = [];
  ApiService api = ApiService.getInstance();
  String _amountSum = "";
  int _userId;
  final _currencyMask = MoneyMaskedTextController(
    precision: 0,
    decimalSeparator: "",
    thousandSeparator: ",",
  );

  void _fetchBalance() {
    api.getUserInfo().then((value) => box.put(Constants.UserInfo, value));
  }

  void _fetchCards() {
    api.getBankCards().then((value) => box.put(Constants.BankCards, value));
  }

  @override
  void initState() {
    _fetchBalance();
    _fetchCards();
    user = box.get(Constants.UserInfo);
    bankCards = box.get(Constants.BankCards) ?? null;
    getUser().then((user) => _userId = user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          /// user future for upper profile information container
          Stack(
            children: [
              Container(
                height: 340.h,
                width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/account_bg.jpg'),
                  ),
                ),
                foregroundDecoration: BoxDecoration(color: Colors.black.withOpacity(0.35)),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 24.h,
                      horizontal: 34.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ID ${user.id}",
                              style: basicStyle3.copyWith(
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                            user.avatar != null
                                ? Container(
                                    height: 156.h,
                                    width: 156.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(user.avatar),
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 156.h,
                                    width: 156.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: Image.asset("assets/images/avatar_placeholder.png").image,
                                      ),
                                    ),
                                  ),
                            Text(
                              user.fullname,
                              style: basicStyle2.copyWith(color: Colors.white),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              user.username,
                              style: basicStyle1.copyWith(color: Colors.white, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        Builder(
                          builder: (context) {
                            var _formatter = NumberFormat.currency(
                                    symbol: '', decimalDigits: user.balance.toString().indexOf('.') == -1 ? 0 : 0)
                                .format(num.parse(user.balance.toString()));
                            return Container(
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.local_atm,
                                      color: skyBlue,
                                      size: 36,
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    "$_formatter UZS",
                                    style: basicStyle2.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          /// replenish label
          Padding(
            padding: EdgeInsets.only(left: 34.w, top: 24.h, bottom: 24.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("replenishBalance", style: basicStyle3).tr(),
            ),
          ),

          /// balance sum field
          Container(
            padding: EdgeInsets.symmetric(horizontal: 34.w),
            decoration: BoxDecoration(boxShadow: kElevationToShadow[16]),
            child: TextField(
              onChanged: (value) {
                _amountSum = value;
              },
              inputFormatters: [
                CurrencyTextFormatter(decimalDigits: 0),
                // CurrencyTextInputFormatter()
              ],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "replenishmentSum".tr(),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ),

          /// "choose card" label
          Padding(
            padding: EdgeInsets.only(left: 34.w, top: 24.h, bottom: 24.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("chooseCard", style: basicStyle3).tr(),
            ),
          ),

          /// bank card future
          Builder(
            builder: (context) {
              List<Widget> cardWidget = [];
              cardWidget = bankCards != null
                  ? List.from(bankCards.map((element) {
                      String expireDate = (element.expireDate % 100).toString() + "/" + (element.expireDate ~/ 100).toString();
                      return BankCardWidget(
                        cardName: element.cardName,
                        cardNumber: element.pan,
                        cardDate: expireDate,
                        cardOwner: element.fullName ?? "",
                      );
                    }))
                  : null;
              cardWidget.add(AddCard(
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) => Dialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                          child: Container(
                              height: 640.h,
                              padding: EdgeInsets.symmetric(
                                // vertical: 24.h,
                                horizontal: 24.w,
                              ),
                              child: CardForm(
                                onSave: (bankCard) {
                                  api.sendCard(bankCard).then((value) {
                                    if (value == 201) setState(() => bankCards.add(bankCard));
                                  });
                                  Navigator.pop(context);
                                },
                              ))))));
              return CarouselSlider(
                options: CarouselOptions(
                  height: 350.h,
                  viewportFraction: 0.9,
                  // aspectRatio: 4/3,
                  enableInfiniteScroll: false,
                ),
                items: cardWidget,
              );
              // return CarouselSlider(
              //   options: CarouselOptions(
              //     height: 350.h,
              //     viewportFraction: 0.9,
              //     // aspectRatio: 4/3,
              //     enableInfiniteScroll: false,
              //   ),
              //   items: [
              //     AddCard(onTap: () {
              //       showDialog(
              //           context: context,
              //           builder: (context) {
              //             return Dialog(
              //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              //               child: Container(
              //                 height: 740.h,
              //                 padding: EdgeInsets.symmetric(
              //                   // vertical: 24.h,
              //                   horizontal: 24.w,
              //                 ),
              //                 child: CardForm(
              //                   onSave: (bankCard) {
              //                     setState(() {
              //                       _fetchCards();
              //                       cardList.add(bankCard);
              //                     });
              //                     _api.sendCard(bankCard);
              //                     Navigator.pop(context);
              //                   },
              //                 ),
              //               ),
              //             );
              //           });
              //     })
              //   ],
              // );
            },
          ),
          SizedBox(height: 24.h),

          /// replenish button
          // ignore: deprecated_member_use
          OutlineButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
            borderSide: BorderSide(color: skyBlue),
            onPressed: () {
              _currencyMask.clear();
              // showSnackBar(context, amountSum);
              // var amount = int.parse(amountSum);
              api.replenishBalance(userId: _userId, replenishSum: _amountSum).then((value) {
                if (value == 200) {
                  showSnackBar(context, "Balance filled");
                  Timer(const Duration(seconds: 1), () => ScaffoldMessenger.of(context).hideCurrentSnackBar());
                  setState(() => _fetchBalance());
                } else {
                  showSnackBar(context, "Request failed");
                  Timer(const Duration(seconds: 1), () => ScaffoldMessenger.of(context).hideCurrentSnackBar());
                }
              }, onError: (e) {
                showSnackBar(context, e.toString());
                Timer(const Duration(seconds: 1), () => ScaffoldMessenger.of(context).hideCurrentSnackBar());
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 24.h,
                horizontal: 128.w,
              ),
              child: Text(
                "replenish",
                style: basicStyle3.copyWith(color: skyBlue),
              ).tr(),
            ),
          ),

          /// some space at the bottom
          SizedBox(height: 48.h),
        ],
      ),
    );
  }
}
