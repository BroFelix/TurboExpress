// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:turbo_express/model/user.dart';
import 'package:turbo_express/model/washing_item.dart';

import 'car.dart';
import 'order_wash_item.dart';
part 'order.g.dart';
Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

@HiveType(typeId: 5)
class Order {
  Order({
    this.id,
    this.created,
    this.startTime,
    this.endTime,
    this.status,
    this.amount,
    this.isGuest,
    this.guestCarNumber,
    this.boxNumb,
    this.car,
    this.carItem,
    this.washing,
    this.washingItem,
    this.user,
    this.userItem,
    this.orderWashItem,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  DateTime created;
  @HiveField(2)
  DateTime startTime;
  @HiveField(3)
  DateTime endTime;
  @HiveField(4)
  int status;
  @HiveField(5)
  int amount;
  @HiveField(6)
  bool isGuest;
  @HiveField(7)
  String guestCarNumber;
  @HiveField(8)
  int boxNumb;
  @HiveField(9)
  int car;
  @HiveField(10)
  Car carItem;
  @HiveField(11)
  int washing;
  @HiveField(12)
  WashingItem washingItem;
  @HiveField(13)
  int user;
  @HiveField(14)
  User userItem;
  @HiveField(15)
  List<OrderWashItem> orderWashItem;

  Order copyWith({
    int id,
    DateTime created,
    DateTime startTime,
    DateTime endTime,
    int status,
    int amount,
    bool isGuest,
    String guestCarNumber,
    int boxNumb,
    int car,
    Car carItem,
    int washing,
    WashingItem washingItem,
    int user,
    User userItem,
    List<OrderWashItem> orderWashItem,
  }) =>
      Order(
        id: id ?? this.id,
        created: created ?? this.created,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        status: status ?? this.status,
        amount: amount ?? this.amount,
        isGuest: isGuest ?? this.isGuest,
        guestCarNumber: guestCarNumber ?? this.guestCarNumber,
        boxNumb: boxNumb ?? this.boxNumb,
        car: car ?? this.car,
        carItem: carItem ?? this.carItem,
        washing: washing ?? this.washing,
        washingItem: washingItem ?? this.washingItem,
        user: user ?? this.user,
        userItem: userItem ?? this.userItem,
        orderWashItem: orderWashItem ?? this.orderWashItem,
      );

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"] == null ? null : json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        startTime: json["start_time"] == null ? null : DateTime.parse(json["start_time"]),
        endTime: json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        status: json["status"] == null ? null : json["status"],
        amount: json["amount"] == null ? null : json["amount"],
        isGuest: json["is_guest"],
        guestCarNumber: json["guest_car_number"],
        boxNumb: json["box_numb"] == null ? null : json["box_numb"],
        car: json["car"] == null ? null : json["car"],
        carItem: json["car_item"] == null ? null : Car.fromJson(json["car_item"]),
        washing: json["washing"] == null ? null : json["washing"],
        washingItem: json["washing_item"] == null ? null : WashingItem.fromJson(json["washing_item"]),
        user: json["user"] == null ? null : json["user"],
        userItem: json["user_item"] == null ? null : User.fromJson(json["user_item"]),
        orderWashItem:
            json["order_wash_item"] == null ? null : List<OrderWashItem>.from(json["order_wash_item"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "created": created == null
            ? null
            : "${created.year.toString().padLeft(4, '0')}-${created.month.toString().padLeft(2, '0')}-${created.day.toString().padLeft(2, '0')}",
        "start_time": startTime == null ? null : startTime.toIso8601String(),
        "end_time": endTime == null ? null : endTime.toIso8601String(),
        "status": status == null ? null : status,
        "amount": amount == null ? null : amount,
        "is_guest": isGuest,
        "guest_car_number": guestCarNumber,
        "box_numb": boxNumb == null ? null : boxNumb,
        "car": car == null ? null : car,
        "car_item": carItem == null ? null : carItem.toJson(),
        "washing": washing == null ? null : washing,
        "washing_item": washingItem == null ? null : washingItem.toJson(),
        "user": user == null ? null : user,
        "user_item": userItem == null ? null : userItem.toJson(),
        "order_wash_item": orderWashItem == null ? null : List<OrderWashItem>.from(orderWashItem.map((x) => x)),
      };
}
