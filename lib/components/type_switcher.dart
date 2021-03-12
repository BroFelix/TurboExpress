import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turbo_express/res/style.dart';
import 'package:easy_localization/easy_localization.dart';

class TypeSwitcher extends StatefulWidget {
  final Function(bool) onChanged;

  TypeSwitcher({@required this.onChanged});

  @override
  _TypeSwitcherState createState() => _TypeSwitcherState();
}

class _TypeSwitcherState extends State<TypeSwitcher> {
  var type = true;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.0),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                type = true;
                widget.onChanged(type);
              });
            },
            child: Container(
              color: type ? Colors.green : Colors.white,
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              child: Text(
                'entity',
                style: basicStyle3.copyWith(
                  color: type ? Colors.white : Colors.black,
                ),
              ).tr(),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                type = false;
                widget.onChanged(type);
              });
            },
            child: Container(
              color: !type ? Colors.green : Colors.white,
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              child: Text(
                'physical',
                style: basicStyle3.copyWith(color: !type ? Colors.white : Colors.black),
              ).tr(),
            ),
          ),
        ],
      ),
    );
  }
}
