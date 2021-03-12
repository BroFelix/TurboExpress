import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:turbo_express/services/auth/auth.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _auth = AuthService();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<int> logIn({
    @required String username,
    @required String password,
  }) async {
    assert(username != null);
    assert(password != null);

    var token = await _auth.login(username, password);
    if (token == null) {
      throw ("Login failed");
    }
    return 0;
  }

  Future<int> register({
    @required String fullName,
    @required String phone,
    @required String password,
    @required Locale language,
    String imagePath,
  }) async {
    assert(fullName != null);
    assert(phone != null);
    assert(password != null);
    assert(language != null);

    int code = await _auth.register(
      name: fullName,
      phone: phone,
      password: password,
      language: language,
    );
    return code;
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
