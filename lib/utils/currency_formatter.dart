import 'dart:math';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyTextFormatter extends TextInputFormatter {
  CurrencyTextFormatter({
    this.locale,
    this.name,
    this.symbol = '',
    this.decimalDigits = 0,
    this.customPattern,
    this.turnOffGrouping = false,
  });

  final String locale;
  final String name;
  final String symbol;
  final int decimalDigits;
  final String customPattern;
  final bool turnOffGrouping;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    bool isInsertedCharacter = oldValue.text.length + 1 == newValue.text.length && newValue.text.startsWith(oldValue.text);
    bool isRemovedCharacter = oldValue.text.length - 1 == newValue.text.length && oldValue.text.startsWith(newValue.text);

    if (!isInsertedCharacter && !isRemovedCharacter) {
      return oldValue;
    }

    final format = NumberFormat.currency(
      locale: locale,
      name: name,
      symbol: symbol,
      decimalDigits: decimalDigits,
      customPattern: customPattern,
    );
    if (turnOffGrouping) {
      format.turnOffGrouping();
    }
    bool isNegative = newValue.text.startsWith('-');
    String newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');

    // If the user wants to remove a digit, but the last character of the
    // formatted text is not a digit (for example, "1,00 €"), we need to remove
    // the digit manually.
    if (isRemovedCharacter && !_lastCharacterIsDigit(oldValue.text)) {
      int length = newText.length - 1;
      newText = newText.substring(0, length > 0 ? length : 0);
    }

    if (newText.trim() == '') {
      return newValue.copyWith(
        text: isNegative ? '-' : '',
        selection: TextSelection.collapsed(offset: isNegative ? 1 : 0),
      );
    } else if (newText == '00' || newText == '000') {
      return TextEditingValue(
        text: isNegative ? '-' : '',
        selection: TextSelection.collapsed(offset: isNegative ? 1 : 0),
      );
    }

    num newInt = int.parse(newText);
    if (decimalDigits > 0) {
      newInt /= pow(10, decimalDigits);
    }
    String newString = (isNegative ? '-' : '') + format.format(newInt).trim();
    newString = newString.replaceAll(',', ' ');
    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(offset: newString.length),
    );
  }

  static bool _lastCharacterIsDigit(String text) {
    String lastChar = text.substring(text.length - 1);
    return RegExp('[0-9]').hasMatch(lastChar);
  }
}
