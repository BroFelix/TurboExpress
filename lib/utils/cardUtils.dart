class CardUtils {
  static String validateDate(String value) {
    int month;
    int year;
    if (value.isEmpty) {
      return 'Введите срок действия карты';
    }

    if (value.contains(RegExp(r'(\/)'))) {
      var split = value.split(RegExp(r'\/'));
      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      month = int.parse(value.substring(0, (value.length)));
      year = -1;
    }

    if (month < 1 || 12 < month) {
      return 'Месяц дейстия карты неверна';
    }
    var fourDigitsYear = convertYearTo4Digits(year);
    return null;
  }

  static int convertYearTo4Digits(int year) {
    var newYear;
    if (0 <= year && year < 100) {
      var currentYear = DateTime.now().year;
      newYear = currentYear - currentYear ~/ 100 + year;
    }
    return newYear;
  }
}
