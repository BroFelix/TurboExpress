import 'package:shared_preferences/shared_preferences.dart';
import 'package:turbo_express/model/token.dart';

saveCurrentLogin(Map responseJson) async {
  var prefs = await SharedPreferences.getInstance();
  var token = (responseJson != null && responseJson.isNotEmpty) ? Token.fromJson(responseJson).token : "";
  await prefs.setString("token", (token != null && token.length > 0) ? token : "");
  await prefs.setInt("user", responseJson["user"]);
}

saveUser(Map responseJson) async {
  var prefs = await SharedPreferences.getInstance();
  await prefs.setInt("user", (responseJson != null ? responseJson["id"] : -1));
}

saveAvatar(String avatar)async{
  var prefs = await SharedPreferences.getInstance();
  await prefs.setString("avatar", avatar);
}