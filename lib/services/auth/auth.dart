import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:turbo_express/common/constants.dart';
import 'package:turbo_express/common/functions/save_current_login.dart';

class AuthService {
  final apiUrl = "${Constants.serverUrl}/api/v1";

  Future register({
    @required String name,
    @required String phone,
    @required String password,
    @required Locale language,
    String imagePath,
  }) async {
    String lang;
    if (language == Locale('uz', 'UZ')) lang = "uz";
    if (language == Locale('ru', 'RU')) lang = "ru";
    if (language == Locale('en', 'US')) lang = "en";
    final url = '$apiUrl/create_user/';
    if (imagePath != null && imagePath != "") {
      var dio = Dio();
      var formData = FormData.fromMap({
        "fullname": name,
        "username": phone,
        "password": password,
        "lang": lang,
        "avatar": await MultipartFile.fromFile(imagePath),
      });
      var response = await dio.post(url, data: formData);
      saveUser(response.data as Map);
      return response.statusCode;
    } else {
      var response = await http.post(
        url,
        body: {
          "fullname": name,
          "username": phone,
          "password": password,
          "lang": lang,
        },
      );
      final responseBody = utf8.decode(response.bodyBytes);
      final responseObj = json.decode(responseBody);
      saveUser(responseObj);
      // print(response.bodyBytes);
      return response.statusCode;
    }
  }

  Future<int> login(String userName, String password) async {
    final url = '$apiUrl/rest-auth/login/';
    String basicAuth = 'Basic ' + base64.encode(utf8.encode('$userName:$password'));
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.contentEncodingHeader: "charset=utf-8",
      },
      body: jsonEncode({
        'username': userName,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final responseObj = jsonDecode(responseBody);
      saveCurrentLogin(responseObj);
      // var token = (responseObj != null && responseObj != "") ? Token.fromJson(responseObj).token : "";
    }
    // print(response.body);
    return response.statusCode;
  }

  Future<int> verify({
    @required String username,
    @required String verifyCode,
  }) async {
    final url = '$apiUrl/user_sms_verify/';
    var response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.contentEncodingHeader: "charset=utf-8",
      },
      body: jsonEncode({"username": username, "sms_code": int.parse(verifyCode)}),
    );
    print(response.body);
    return response.statusCode;
  }

  Future getVerifySMS({@required String username}) async {
    final url = "$apiUrl/user/send_sms_for_password/";
    var response = await http.post(
      url,
      // headers: {HttpHeaders.contentTypeHeader: "json/application", HttpHeaders.contentEncodingHeader: "charset=utf-8"},
      body: {"username": username},
    );
    print(response.body);
    return response.statusCode;
  }

  Future forgotPassword({
    @required String sms,
    @required String username,
    @required String password,
  }) async {
    final url = "$apiUrl/user/forgot_password/";
    var response = await http.post(
      url,
      // headers: {HttpHeaders.contentTypeHeader: "json/application", HttpHeaders.contentEncodingHeader: "charset=utf-8"},
      body: <String, dynamic>{
        "username": username,
        "password": password,
        "sms_code": sms,
      },
    );
    print(response.body);
    return response.statusCode;
  }
}
