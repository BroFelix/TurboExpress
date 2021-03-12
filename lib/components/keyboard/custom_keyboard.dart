import 'package:cool_ui/cool_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomKeyboard extends StatelessWidget {
  /// Define InputType type
  static const CKTextInputType numberType = const CKTextInputType(name: 'NewKeyboard');

  static double getHeight(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.width / 3 / 2 * 5;
  }

  final KeyboardController controller; // Controller used to control keyboard output
  const CustomKeyboard({this.controller});

  static register() {
    /// How to register the keyboard
    CoolKeyboard.addKeyboard(
        CustomKeyboard.numberType,
        KeyboardConfig(
            builder: (context, controller, params) {
              // Parameters can be passed to the keyboard through CKTextInputType
              return CustomKeyboard(controller: controller);
            },
            getHeight: CustomKeyboard.getHeight));
  }

  @override
  Widget build(BuildContext context) {
    ///The specific content of the keyboard

    final mediaQuery = MediaQuery.of(context);
    return Material(
      child: DefaultTextStyle(
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 32.nsp,
        ),
        child: Container(
          height: getHeight(context),
          width: mediaQuery.size.width,
          decoration: BoxDecoration(color: Colors.grey),
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 2.0 / 1.0,
            mainAxisSpacing: 0.5,
            crossAxisSpacing: 0.5,
            padding: EdgeInsets.all(0.0),
            crossAxisCount: 3,
            children: [
              buildButton("01", value: "01"),
              buildButton("10", value: "10"),
              buildButton("30", value: "30"),
              buildButton("20", value: "20"),
              buildButton("25", value: "25"),
              buildButton("40", value: "40"),
              buildButton("50", value: "50"),
              buildButton("60", value: "60"),
              buildButton("70", value: "70"),
              buildButton("75", value: "75"),
              buildButton("80", value: "80"),
              buildButton("85", value: "85"),
              buildButton("90", value: "90"),
              buildButton("95", value: "95"),
              MaterialButton(
                color: Color(0xFFd3d6dd),
                onPressed: () => controller.clear(),
                child: Center(child: Text('X')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(String title, {String value}) {
    return MaterialButton(
      shape: RoundedRectangleBorder(),
      color: Colors.white,
      child: Text(title),
      onPressed: () {
        controller.clear();
        controller.addText(value ?? title);
      },
    );
  }
}
