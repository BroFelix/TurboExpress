// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'user.g.dart';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 9)
class User {
  User({
    this.id,
    this.created,
    this.avatar,
    this.updated,
    this.username,
    this.fullname,
    this.smsVerify,
    this.smsLive,
    this.cardNumber,
    this.lang,
    this.balance,
    this.status,
    this.password,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  DateTime created;
  @HiveField(2)
  String avatar;
  @HiveField(3)
  DateTime updated;
  @HiveField(4)
  String username;
  @HiveField(5)
  String fullname;
  @HiveField(6)
  int smsVerify;
  @HiveField(7)
  bool smsLive;
  @HiveField(8)
  String cardNumber;
  @HiveField(9)
  String lang;
  @HiveField(10)
  int balance;
  @HiveField(11)
  int status;
  @HiveField(12)
  String password;

  User copyWith({
    int id,
    DateTime created,
    dynamic avatar,
    DateTime updated,
    String username,
    String fullname,
    int smsVerify,
    dynamic smsLive,
    String cardNumber,
    String lang,
    int balance,
    int status,
    String password,
  }) =>
      User(
        id: id ?? this.id,
        created: created ?? this.created,
        avatar: avatar ?? this.avatar,
        updated: updated ?? this.updated,
        username: username ?? this.username,
        fullname: fullname ?? this.fullname,
        smsVerify: smsVerify ?? this.smsVerify,
        smsLive: smsLive ?? this.smsLive,
        cardNumber: cardNumber ?? this.cardNumber,
        lang: lang ?? this.lang,
        balance: balance ?? this.balance,
        status: status ?? this.status,
        password: password ?? this.password,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        created: DateTime.parse(json["created"]),
        avatar: json["avatar"] ?? null,
        updated: DateTime.parse(json["updated"]),
        username: json["username"],
        fullname: json["fullname"] == null ? null : json["fullname"],
        smsVerify: json["sms_verify"],
        smsLive: json["sms_live"],
        cardNumber: json["card_number"] == null ? null : json["card_number"],
        lang: json["lang"],
        balance: json["balance"],
        status: json["status"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? null,
        "created": created != null ? created.toIso8601String() : null,
        "avatar": avatar ?? null,
        "updated": updated != null ? updated.toIso8601String() : null,
        "username": username,
        "fullname": fullname == null ? null : fullname,
        "sms_verify": smsVerify,
        "sms_live": smsLive,
        "card_number": cardNumber == null ? null : cardNumber,
        "lang": lang,
        "balance": balance,
        "status": status,
        "password": password,
      };
}
