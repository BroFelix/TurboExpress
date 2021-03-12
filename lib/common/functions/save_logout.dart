import 'package:shared_preferences/shared_preferences.dart';

void saveLogOut() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
