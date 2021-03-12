import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turbo_express/screens/balance/balance.dart';
import 'package:turbo_express/screens/createUserWash/createUserWash.dart';
import 'package:turbo_express/screens/myTemplate/myTemplate.dart';
import 'package:turbo_express/screens/payForFriend/payForFriend.dart';
import 'package:turbo_express/screens/paymentHistory/listOfFriendPayments.dart';
import 'package:turbo_express/screens/settings/settings.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            ListTile(
              title: Text('createUserWash').tr(),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CreateUserWashScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text("myTemplates").tr(),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => MyTemplatesScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text("friendPaymentHistory").tr(),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ListOfFriendPaymentScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('payForFriend').tr(),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PayForFriendScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('settings').tr(),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SettingsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text("balanceReplenishment").tr(),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BalanceScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
