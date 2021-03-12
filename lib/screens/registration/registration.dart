import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turbo_express/screens/registration/components/body.dart';

class RegistrationScreen extends StatefulWidget {
  static const route = '/signUp';

  static Route routeBuilder() {
    return MaterialPageRoute(builder: (_) {
      return RegistrationScreen();
    });
  }

  @override
  State<StatefulWidget> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegistrationBody(),
    );
  }
}
