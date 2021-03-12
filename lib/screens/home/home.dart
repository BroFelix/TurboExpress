import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:turbo_express/common/constants.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/services/api/api.dart';

import 'components/pages/history.dart';
import 'components/pages/home_fragment.dart';
import 'components/pages/profile.dart';
import 'components/pages/service.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home';

  static Route routeBuilder() {
    return MaterialPageRoute(builder: (context) => HomeScreen());
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _navKey = GlobalKey<NavigatorState>();
  int _currentIndex = 0;
  var api = ApiService.getInstance();
  var box = Hive.box(Constants.API_BOX);

  @override
  void initState() {
    api.getAllUserData().then((data) {
      if (data != null) {
        box.put(Constants.UserInfo, data.userInfo[0] ?? null);
        box.put(Constants.UserCards, data.userCard ?? null);
        box.put(Constants.OrderInProgress, data.orderInProgress ?? null);
        box.put(Constants.UserWash, data.userWashes ?? null);
        box.put(Constants.Orders, data.completeOrders ?? null);
        box.put(Constants.Cars, data.cars ?? null);
        box.put(Constants.BankCards, data.debitCards);
      }
    });
    super.initState();
  }

  final List<Widget> _children = [
    HomeFragment(),
    ServicePage(),
    HistoryPage(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        top: false,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _children[_currentIndex],
        ),
      ),
      // drawer: HomeDrawer(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          unselectedItemColor: Colors.grey,
          selectedItemColor: skyBlue,
          items: [
            BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.home), label: 'home'.tr()),
            BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.server), label: 'services'.tr()),
            BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.history), label: 'history'.tr()),
            BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.user), label: 'profile'.tr()),
          ]),
    );
  }
}
