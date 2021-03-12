import 'package:flutter/cupertino.dart';
import 'package:turbo_express/screens/forgot/forgot_password.dart';
import 'package:turbo_express/screens/forgot/verify.dart';
import 'package:turbo_express/screens/home/home.dart';
import 'package:turbo_express/screens/login/login.dart';
import 'package:turbo_express/screens/onboarding/onboarding.dart';
import 'package:turbo_express/screens/registration/registration.dart';

class Routes {
  static final route = <String, WidgetBuilder>{
    HomeScreen.route: (context) => HomeScreen(),
    OnBoarding.route: (context) => OnBoarding(),
    RegistrationScreen.route: (context) => RegistrationScreen(),
    LoginScreen.route: (context) => LoginScreen(),
    ForgotPasswordScreen.route: (context) => ForgotPasswordScreen(),
    VerificationScreen.route: (context) => VerificationScreen(),
  };
}
