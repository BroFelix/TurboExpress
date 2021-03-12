import 'dart:async';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turbo_express/model/user.dart';
import 'package:turbo_express/services/api/api.dart';
import 'package:turbo_express/services/auth/auth.dart';
import 'package:turbo_express/services/auth/user.dart';

class UserRepository {
  User user;
  var _auth = AuthService();

  Future<void> changePassword({
    @required int userId,
    @required String oldPassword,
    @required String newPassword,
  }) async {
    var token = await getToken();
    var response = await UserAPI().changePassword(userId, token, oldPassword, newPassword);
    return response;
  }

  Future<User> getUser(// {@required int userId,}
      ) async {
    user = await ApiService.getInstance().getUserInfo();
    return user;
  }

  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    var token = await _auth.login(username, password);
    // return token;
  }

  Future edit({
    @required User user,
  }) async {
    var response = await UserAPI().edit(user);
    return response;
  }

  Future uploadAvatar({
    @required User user,
    @required File image,
  }) async {
    var response = await UserAPI().uploadAvatar(user, image);
    return response;
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }

  Future<String> getToken() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<int> getUserId() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }
}
