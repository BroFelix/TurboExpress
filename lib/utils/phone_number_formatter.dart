import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    bool isInsertedCharacter =
        oldValue.text.length + 1 == newValue.text.length &&
            newValue.text.startsWith(oldValue.text);
    bool isRemovedCharacter =
        oldValue.text.length - 1 == newValue.text.length &&
            oldValue.text.startsWith(newValue.text);
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (isInsertedCharacter) {
      if (newTextLength == 1) {
        newText.write('+998 (');
        if (newValue.selection.end == 1) selectionIndex += 6;
      }
      if (newTextLength == 8) {
        newText
            .write(newValue.text.substring(0, usedSubstringIndex = 8) + ') ');
        // print(newValue.text.substring(0, usedSubstringIndex = 8));
        selectionIndex += 2;
      }
      if (newTextLength == 13) {
        newText
            .write(newValue.text.substring(0, usedSubstringIndex = 13) + '-');
        selectionIndex++;
      }
      if (newTextLength == 16) {
        newText
            .write(newValue.text.substring(0, usedSubstringIndex = 16) + '-');
        selectionIndex++;
      }
    }
    if (isRemovedCharacter) {
      if (newTextLength == 5) {
        newText.clear();
      }
    }
    // print("$newTextLength : $usedSubstringIndex");

    if (newTextLength > usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
