import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turbo_express/common/functions/get_token.dart';
import 'package:turbo_express/common/functions/get_user.dart';

import 'background_layer.dart';
import 'foreground_layer.dart';

class OnBoardBody extends StatefulWidget {
  @override
  _OnBoardBodyState createState() => _OnBoardBodyState();
}

class _OnBoardBodyState extends State<OnBoardBody> {
  final _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final int _numPages = 3;
  String _language;
  var token;
  var id;

  @override
  void initState() {
    getToken().then((tokenKey) => token = tokenKey);
    getUser().then((user) => id = user);
    super.initState();
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        BackgroundLayer(
          size: size,
          pageController: _pageController,
          onPageChanged: (page) => setState(() => _currentPage = page),
        ),
        ForegroundLayer(
          size: size,
          currentPage: _currentPage,
          indicators: _buildPageIndicator(),
          skipPressed: () => setState(() {
            _currentPage = 2;
            _pageController.jumpToPage(2);
          }),
          language: _language,
          languageChanged: (value) {
            switch (value) {
              case 0:
                setState(() => context.locale = context.supportedLocales[0]);
                break;
              case 1:
                setState(() => context.locale = context.supportedLocales[1]);
                break;
              case 2:
                setState(() => context.locale = context.supportedLocales[2]);
                break;
            }
          },
        ),
      ],
    );
  }
}
