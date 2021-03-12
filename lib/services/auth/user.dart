import 'dart:io';

import 'package:turbo_express/model/user.dart';

class UserAPI {
  Future<void> edit(User user) {
    //TODO: Implement edit api
    return null;
  }

  Future<void> uploadAvatar(User user, File image) {
    //TODO: Implement avatar upload api
    return null;
  }

  Future<void> changePassword(
      int userId, String token, String oldPassword, String newPassword) async {

  }
}
