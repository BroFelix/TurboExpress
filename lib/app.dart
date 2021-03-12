import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:turbo_express/routes.dart';
import 'package:turbo_express/screens/splash/splash.dart';

class App extends StatefulWidget {
  // static void restartApp(BuildContext context) => context.findAncestorStateOfType<_AppState>().restartApp();

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // final _navigatorKey = GlobalKey<NavigatorState>();
  Key _key = UniqueKey();

  // NavigatorState get _navigator => _navigatorKey.currentState;

  // void restartApp() => setState(() => _key = UniqueKey());

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: _key,
      child: ScreenUtilInit(
        designSize: Size(750, 1334),
        allowFontScaling: false,
        builder: () => MaterialApp(
          title: 'Turbo Express',
          // navigatorKey: _navigatorKey,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          /*builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    _navigator.pushAndRemoveUntil(HomeScreen.route(), (route) => false);
                    break;
                  case AuthenticationStatus.unauthenticated:
                    _navigator.pushAndRemoveUntil(OnBoarding.route(), (route) => false);
                    break;
                  case AuthenticationStatus.unknown:
                    _navigator.pushAndRemoveUntil(OnBoarding.route(), (route) => false);
                    break;
                  default:
                    break;
                }
              },
              child: child,
            );
          },
          onGenerateRoute: (settings) {
            return SplashScreen.route();
          },*/
          routes: Routes.route,
          home: SplashScreen(),
        ),
      ),
    );
  }
}
