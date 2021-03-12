// To parse this JSON data, do
//
//     final userCard = userCardFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'user_card.g.dart';

List<UserCard> userCardFromJson(String str) => List<UserCard>.from(json.decode(str).map((x) => UserCard.fromJson(x)));

String userCardToJson(List<UserCard> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 10)
class UserCard {
  UserCard({
    this.id,
    this.beginDate,
    this.endDate,
    this.cardNumber,
    this.discountAmount,
    this.status,
    this.user,
    this.cardType,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  DateTime beginDate;
  @HiveField(2)
  DateTime endDate;
  @HiveField(3)
  String cardNumber;
  @HiveField(4)
  double discountAmount;
  @HiveField(5)
  int status;
  @HiveField(6)
  int user;
  @HiveField(7)
  int cardType;

  UserCard copyWith({
    int id,
    DateTime beginDate,
    DateTime endDate,
    String cardNumber,
    int discountAmount,
    int status,
    int user,
    dynamic cardType,
  }) =>
      UserCard(
        id: id ?? this.id,
        beginDate: beginDate ?? this.beginDate,
        endDate: endDate ?? this.endDate,
        cardNumber: cardNumber ?? this.cardNumber,
        discountAmount: discountAmount ?? this.discountAmount,
        status: status ?? this.status,
        user: user ?? this.user,
        cardType: cardType ?? this.cardType,
      );

  factory UserCard.fromJson(Map<String, dynamic> json) => UserCard(
        id: json["id"],
        beginDate: DateTime.parse(json["begin_date"]),
        endDate: DateTime.parse(json["end_date"]),
        cardNumber: json["card_number"],
        discountAmount: json["discount_amount"],
        status: json["status"],
        user: json["user"],
        cardType: json["card_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "begin_date":
            "${beginDate.year.toString().padLeft(4, '0')}-${beginDate.month.toString().padLeft(2, '0')}-${beginDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "card_number": cardNumber,
        "discount_amount": discountAmount,
        "status": status,
        "user": user,
        "card_type": cardType,
      };
}
