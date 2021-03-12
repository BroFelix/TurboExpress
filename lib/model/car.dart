// To parse this JSON data, do
// final car = carFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'car.g.dart';

List<Car> carFromJson(String str) => List<Car>.from(json.decode(str).map((x) => Car.fromJson(x)));

String carToJson(List<Car> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 1)
class Car {
  Car({
    this.id,
    this.title,
    this.created,
    this.updated,
    this.user,
    this.carType,
    this.carNumber,
    this.status,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  DateTime created;

  @HiveField(3)
  DateTime updated;

  @HiveField(4)
  int user;

  @HiveField(5)
  int carType;

  @HiveField(6)
  String carNumber;

  @HiveField(7)
  int status;

  Car copyWith({
    int id,
    String title,
    DateTime created,
    DateTime updated,
    int user,
    int carType,
    String carNumber,
    int status,
  }) =>
      Car(
        id: id ?? this.id,
        title: title ?? this.title,
        created: created ?? this.created,
        updated: updated ?? this.updated,
        user: user ?? this.user,
        carType: carType ?? this.carType,
        carNumber: carNumber ?? this.carNumber,
        status: status ?? this.status,
      );

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["id"],
        title: json["title"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        user: json["user"],
        carType: json["car_type"],
        carNumber: json["car_number"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "created": (created ?? "").toString(),
        "updated": (updated ?? "").toString(),
        "user": user,
        "car_type": carType,
        "car_number": carNumber,
        "status": status,
      };
}
