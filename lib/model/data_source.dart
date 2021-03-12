// To parse this JSON data, do
//
//     final dataSource = dataSourceFromJson(jsonString);

import 'dart:convert';

import 'package:turbo_express/model/bank_card.dart';
import 'package:turbo_express/model/car.dart';
import 'package:turbo_express/model/order.dart';
import 'package:turbo_express/model/user.dart';
import 'package:turbo_express/model/user_card.dart';

import 'order_in_progress.dart';
import 'user_wash.dart';

DataSource dataSourceFromJson(String str) => DataSource.fromJson(json.decode(str));

String dataSourceToJson(DataSource data) => json.encode(data.toJson());

class DataSource {
  DataSource({
    this.userInfo,
    this.userCard,
    this.orderInProgress,
    this.userWashes,
    this.completeOrders,
    this.cars,
    this.debitCards,
  });

  List<User> userInfo;
  List<UserCard> userCard;
  List<OrderInProgress> orderInProgress;
  List<UserWash> userWashes;
  List<Order> completeOrders;
  List<Car> cars;
  List<BankCard> debitCards;

  factory DataSource.fromJson(Map<String, dynamic> json) => DataSource(
    userInfo: json["user_info"] == null ? null : List<User>.from(json["user_info"].map((x) => User.fromJson(x))),
    userCard: json["user_card"] == null ? null : List<UserCard>.from(json["user_card"].map((x) => UserCard.fromJson(x))),
    orderInProgress: json["order_in_progress"] == null ? null : List<OrderInProgress>.from(json["order_in_progress"].map((x) => OrderInProgress.fromJson(x))),
    userWashes: json["user_washes"] == null ? null : List<UserWash>.from(json["user_washes"].map((x) => UserWash.fromJson(x))),
    completeOrders: json["complete_orders"] == null ? null : List<Order>.from(json["complete_orders"].map((x) => Order.fromJson(x))),
    cars: json["cars"]==null? null : List<Car>.from(json["cars"].map((x)=>Car.fromJson(x))),
    debitCards: json["debit_card"]==null? null : List<BankCard>.from(json["debit_card"].map((x) => BankCard.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_info": userInfo == null ? null : List<dynamic>.from(userInfo.map((x) => x.toJson())),
    "user_card": userCard == null ? null : List<dynamic>.from(userCard.map((x) => x)),
    "order_in_progress": orderInProgress == null ? null : List<dynamic>.from(orderInProgress.map((x) => x.toJson())),
    "user_washes": userWashes == null ? null : List<dynamic>.from(userWashes.map((x) => x.toJson())),
    "complete_orders": completeOrders == null ? null : List<dynamic>.from(completeOrders.map((x) => x)),
    "cars": cars==null? null:List<dynamic>.from(cars.map((e) => e)),
    "debitCards":debitCards==null?null:List<dynamic>.from(debitCards.map((e) => e)),
  };
}
