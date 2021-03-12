import 'package:shared_preferences/shared_preferences.dart';

Future<int> getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt("user");
}

Future<String> getAvatar() async {
  var prefs = await SharedPreferences.getInstance();
  return prefs.getString("avatar");
}
