import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turbo_express/common/functions/get_user.dart';
import 'package:turbo_express/model/bank_card.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/res/style.dart';
import 'package:turbo_express/utils/cardUtils.dart';

class CardForm extends StatefulWidget {
  final Function(BankCard) onSave;

  const CardForm({Key key, this.onSave}) : super(key: key);

  @override
  _CardFormState createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {
  String cardName = "";
  String cardNumber = "";
  String cardDate = "";
  String cardFullName = "";
  int userId;
  final _cardNumberController = MaskedTextController(mask: '0000 0000 0000 0000');
  final _expiryDateController = MaskedTextController(mask: '@#/00', translator: {
    '0': RegExp(r'[0-9]'),
    '@': RegExp(r'[0-1]'),
    '#': RegExp(r'[1-9]'),
  });
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getUser().then((value) => userId = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 24.h,
                  // horizontal: 24.w,
                ),
                child: Text(
                  "addCard",
                  style: basicStyle4,
                ).tr(),
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              decoration: BoxDecoration(boxShadow: kElevationToShadow[16]),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                controller: _cardNumberController,
                validator: (value) => value.isEmpty ? "fillTheField".tr() : null,
                onSaved: (value) => cardNumber = value,
                keyboardType: TextInputType.number,
                // onChanged: (value) => cardNumber += value,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "cardNumber".tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              decoration: BoxDecoration(boxShadow: kElevationToShadow[16]),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                controller: _expiryDateController,
                validator: (value) => CardUtils.validateDate(value),
                keyboardType: TextInputType.number,
                onSaved: (value) => cardDate = value,
                // onChanged: (value) => cardDate += value,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "cardDate".tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              decoration: BoxDecoration(boxShadow: kElevationToShadow[16]),
              child: TextFormField(
                onSaved: (value) => cardName = value,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                // onChanged: (value) => cardName += value,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "cardName".tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                // ignore: deprecated_member_use
                child: OutlineButton(
                  padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 72.w),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                  borderSide: BorderSide(color: skyBlue),
                  clipBehavior: Clip.antiAlias,
                  onPressed: () {
                    BankCard card;
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      var temp1 = cardDate.substring(3, 5);
                      var temp2 = cardDate.substring(0, 2);
                      var a = int.parse(temp1);
                      var b = int.parse(temp2);
                      int expireDate = a * 100 + b;
                      card = BankCard(
                        expireDate: expireDate,
                        pan: cardNumber,
                        cardName: cardName,
                        fullName: cardFullName,
                        user: userId,
                      );
                      widget.onSave.call(card);
                    }
                  },
                  child: Text("save", style: basicStyle3.copyWith(color: skyBlue)).tr(),
                ),
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
