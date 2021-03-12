// To parse this JSON data, do
//
//     final bankCard = bankCardFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'bank_card.g.dart';

BankCard bankCardFromJson(String str) => BankCard.fromJson(json.decode(str));

String bankCardToJson(BankCard data) => json.encode(data.toJson());

@HiveType(typeId: 0)
class BankCard {
  BankCard({
    this.id,
    this.created,
    this.pan,
    this.expireDate,
    this.cardName,
    this.fullName,
    this.cardType,
    this.isMain,
    this.user,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  DateTime created;

  @HiveField(2)
  String pan;

  @HiveField(3)
  int expireDate;

  @HiveField(4)
  String cardName;

  @HiveField(5)
  String fullName;

  @HiveField(6)
  int cardType;

  @HiveField(7)
  bool isMain;

  @HiveField(8)
  int user;

  BankCard copyWith({
    int id,
    DateTime created,
    String pan,
    int expireDate,
    String cardName,
    String fullName,
    int cardType,
    bool isMain,
    int user,
  }) =>
      BankCard(
        id: id ?? this.id,
        created: created ?? this.created,
        pan: pan ?? this.pan,
        expireDate: expireDate ?? this.expireDate,
        cardName: cardName ?? this.cardName,
        fullName: fullName ?? this.fullName,
        cardType: cardType ?? this.cardType,
        isMain: isMain ?? this.isMain,
        user: user ?? this.user,
      );

  factory BankCard.fromJson(Map<String, dynamic> json) => BankCard(
        id: json["id"],
        created: DateTime.parse(json["created"]),
        pan: json["pan"],
        expireDate: json["expire_date"],
        cardName: json["card_name"],
        fullName: json["full_name"],
        cardType: json["card_type"],
        isMain: json["is_main"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "created": this.created,
        "pan": this.pan,
        "expire_date": this.expireDate,
        "title": this.cardName,
        "full_name": this.fullName,
        "card_type": this.cardType,
        "is_main": this.isMain,
        "user": this.user,
      };
}
