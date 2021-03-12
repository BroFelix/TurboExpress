import 'package:cool_ui/cool_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turbo_express/components/keyboard/custom_keyboard.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/res/style.dart';

class CarNumberTextField extends StatefulWidget {
  final String label;
  final double height;
  final double fontSize;
  final double iconSize;
  final bool entityType;
  final double labelSize;
  final StrutStyle strutStyle;
  final double countryLabelSize;
  final customNotifier;
  final Function(String) onSubmitted;

  CarNumberTextField({
    this.customNotifier,
    this.label,
    this.height,
    this.fontSize,
    this.iconSize,
    this.labelSize,
    this.strutStyle,
    this.countryLabelSize,
    this.entityType = false,
    this.onSubmitted,
  });

  @override
  _CarNumberTextFieldState createState() => _CarNumberTextFieldState();
}

class _CarNumberTextFieldState extends State<CarNumberTextField> {
  _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  var _regionCodeControllerEntity = TextEditingController();
  var _firstLabelControllerEntity = TextEditingController();
  var _carNumberControllerEntity = TextEditingController();
  var _lastLabelsControllerEntity = TextEditingController();

  var _regionCodeControllerJure = TextEditingController();
  var _carNumberControllerJure = TextEditingController();
  var _lastLabelsControllerJure = TextEditingController();

  final FocusNode _regionFocusEntity = FocusNode();
  final FocusNode _firstLabelFocusEntity = FocusNode();
  final FocusNode _carNumberFocusEntity = FocusNode();
  final FocusNode _lastLabelsFocusEntity = FocusNode();

  final FocusNode _regionFocusJure = FocusNode();
  final FocusNode _carNumberFocusJure = FocusNode();
  final FocusNode _lastLabelsFocusJure = FocusNode();

  String _carLabel = "";

  @override
  Widget build(BuildContext context) {
    return KeyboardMediaQuery(
      child: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        child: !widget.entityType
            ?

            /// Builder used for clearing text fields when type of input changes
            /// This Builder Widget presents CarNumber for Individual entities
            Builder(
                builder: (context) {
                  /// Text controllers
                  _regionCodeControllerJure.clear();
                  _carNumberControllerJure.clear();
                  _lastLabelsControllerJure.clear();

                  /// Container contains layout of input car number
                  return Container(
                    /// Max height defined as 128.h
                    height: 128.h,

                    /// width is 0.9 * ScreenSize.width
                    width: 0.9.sw,
                    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 24.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 6.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// This Container contains region code of the car's number e.g. "30"
                        Container(
                          width: 120.w,
                          margin: EdgeInsets.only(right: 8.w),
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.center,
                            keyboardType: CustomKeyboard.numberType,
                            textInputAction: TextInputAction.next,
                            controller: _regionCodeControllerEntity,
                            focusNode: _regionFocusEntity,
                            onChanged: (value) {
                              if (value.length == 2) {
                                _carLabel += value;
                                _carLabel += "|";
                                _fieldFocusChange(context, _regionFocusEntity, _firstLabelFocusEntity);
                              }
                            },
                            onSubmitted: (value) {},
                            showCursor: true,
                            style: carNumberStyle,
                            maxLength: 2,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            buildCounter: (BuildContext context, {int currentLength, int maxLength, bool isFocused}) =>
                                null,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                              border: InputBorder.none,
                              hintText: '77',
                            ),
                          ),
                        ),
                        VerticalDivider(color: Colors.black, width: 8.0, thickness: 2.0),

                        /// This Container contains first letter of car number e.g."A"
                        /// TextField height self defined
                        Container(
                          width: 64.w,
                          margin: EdgeInsets.only(left: 8.w),
                          child: TextField(
                            controller: _firstLabelControllerEntity,
                            onChanged: (value) {
                              if (value.length == 1) {
                                _carLabel += value;
                                _fieldFocusChange(
                                  context,
                                  _firstLabelFocusEntity,
                                  _carNumberFocusEntity,
                                );
                              }
                            },
                            focusNode: _firstLabelFocusEntity,
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.center,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[A-Z]"))],
                            textInputAction: TextInputAction.next,
                            style: carNumberStyle,
                            maxLength: 1,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.characters,
                            buildCounter: (BuildContext context, {int currentLength, int maxLength, bool isFocused}) =>
                                null,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                              hintText: 'A',
                            ),
                          ),
                        ),

                        /// This Container contains 3 numerical letters of car number e.g. "123"
                        /// Container used to give TextField ability to self define height according content size
                        Container(
                          width: 168.w,
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          child: TextField(
                            controller: _carNumberControllerEntity,
                            onChanged: (value) {
                              if (value.length == 3) {
                                _carLabel += value;
                                _fieldFocusChange(
                                  context,
                                  _carNumberFocusEntity,
                                  _lastLabelsFocusEntity,
                                );
                              }
                            },
                            focusNode: _carNumberFocusEntity,
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            textInputAction: TextInputAction.next,
                            style: carNumberStyle,
                            maxLength: 3,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            buildCounter: (BuildContext context, {int currentLength, int maxLength, bool isFocused}) =>
                                null,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                              hintText: '123',
                            ),
                          ),
                        ),

                        /// last letters in car number e.g. "AA"
                        /// Container used to make height of TextField self-determining
                        Container(
                          width: 128.w,
                          child: TextField(
                            controller: _lastLabelsControllerEntity,
                            onChanged: (value) {
                              if (value.length == 2) {
                                _carLabel += value;
                                widget.onSubmitted(_carLabel);
                                _lastLabelsFocusEntity.unfocus();
                                // print(_carLabel);
                              }
                            },
                            focusNode: _lastLabelsFocusEntity,
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            textInputAction: TextInputAction.done,
                            style: carNumberStyle,
                            maxLength: 2,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            textCapitalization: TextCapitalization.characters,
                            keyboardType: TextInputType.text,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[A-Z]"))],
                            buildCounter: (BuildContext context, {int currentLength, int maxLength, bool isFocused}) =>
                                null,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'AA',
                              contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                            ),
                          ),
                        ),

                        /// UZB flag and code
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 4.h),
                                child: SvgPicture.asset(
                                  'assets/icons/flag.svg',
                                  height: 32.h,
                                  width: 36.w,
                                ),
                              ),
                              Text(
                                'UZ',
                                textWidthBasis: TextWidthBasis.longestLine,
                                style: basicStyle5.copyWith(
                                  color: skyBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                      ],
                    ),
                  );
                },
              )
            :

            /// Builder used for clearing text fields when type of input changes
            /// This Builder Widget presents CarNumber for Juridical entities
            Builder(
                builder: (context) {
                  /// TextField controllers cleared
                  _regionCodeControllerEntity.clear();
                  _firstLabelControllerEntity.clear();
                  _carNumberControllerEntity.clear();
                  _lastLabelsControllerEntity.clear();
                  _carLabel = "";

                  /// Container main root of car number layout
                  return Container(
                    height: 128.h,
                    width: 0.9.sw,
                    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 24.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 6.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// this container represents region code of car number e.g. "01"
                        /// height self defined
                        Container(
                          width: 120.w,
                          margin: EdgeInsets.only(right: 8.w),
                          child: TextField(
                            keyboardType: CustomKeyboard.numberType,
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            controller: _regionCodeControllerJure,
                            focusNode: _regionFocusJure,
                            onSubmitted: (value) {},
                            onChanged: (value) {
                              if (value.length == 2) {
                                _carLabel += value;
                                _carLabel += "|";
                                _fieldFocusChange(
                                  context,
                                  _regionFocusJure,
                                  _carNumberFocusJure,
                                );
                              }
                            },
                            showCursor: true,
                            style: carNumberStyle,
                            textInputAction: TextInputAction.next,
                            maxLength: 2,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            buildCounter: (BuildContext context, {int currentLength, int maxLength, bool isFocused}) =>
                                null,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                              border: InputBorder.none,
                              hintText: '77',
                            ),
                          ),
                        ),
                        VerticalDivider(color: Colors.black, width: 8.0, thickness: 2.0),

                        /// this container presents 3 numerical letters in juridical numbers e.g. "123"
                        Container(
                          width: 168.w,
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          child: TextField(
                            controller: _carNumberControllerJure,
                            onChanged: (value) {
                              if (value.length == 3) {
                                _carLabel += value;
                                _fieldFocusChange(context, _carNumberFocusJure, _lastLabelsFocusJure);
                              }
                            },
                            focusNode: _carNumberFocusJure,
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            textInputAction: TextInputAction.next,
                            style: carNumberStyle,
                            maxLength: 3,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            buildCounter: (BuildContext context, {int currentLength, int maxLength, bool isFocused}) =>
                                null,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                              hintText: '123',
                            ),
                          ),
                        ),

                        /// this container presents last alphabetical letters of juridical car number
                        /// height self defined
                        Container(
                          width: 168.w,
                          child: TextField(
                            controller: _lastLabelsControllerJure,
                            onSubmitted: (value) {},
                            onChanged: (value) {
                              if (value.length == 3) {
                                _carLabel += value;
                                // print(_carLabel);
                                widget.onSubmitted(_carLabel);
                                _lastLabelsFocusJure.unfocus();
                              }
                            },
                            focusNode: _lastLabelsFocusJure,
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            textInputAction: TextInputAction.done,
                            style: carNumberStyle,
                            maxLength: 3,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            textCapitalization: TextCapitalization.characters,
                            keyboardType: TextInputType.text,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[A-Z]"))],
                            buildCounter: (BuildContext context, {int currentLength, int maxLength, bool isFocused}) =>
                                null,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'AAA',
                              contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                            ),
                          ),
                        ),

                        /// this container presents UZB flag and code
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 4.h),
                                child: SvgPicture.asset(
                                  'assets/icons/flag.svg',
                                  height: 32.h,
                                  width: 36.w,
                                ),
                              ),
                              Text(
                                'UZ',
                                textWidthBasis: TextWidthBasis.longestLine,
                                style: basicStyle5.copyWith(
                                  color: skyBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
