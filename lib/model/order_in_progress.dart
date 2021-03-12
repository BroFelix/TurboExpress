// To parse this JSON data, do
//
//     final orderInProgress = orderInProgressFromJson(jsonString);
import 'package:hive/hive.dart';

part 'order_in_progress.g.dart';

@HiveType(typeId: 6)
class OrderInProgress {
  OrderInProgress({
    this.id,
    this.created,
    this.status,
    this.user,
    this.washingTemp,
    this.carNumber,
    this.amount,
    this.usedDate,
    this.cashier,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  DateTime created;
  @HiveField(2)
  int status;
  @HiveField(3)
  int user;
  @HiveField(4)
  int washingTemp;
  @HiveField(5)
  String carNumber;
  @HiveField(6)
  double amount;
  @HiveField(7)
  DateTime usedDate;
  @HiveField(8)
  int cashier;

  OrderInProgress copyWith({
    int id,
    DateTime created,
    int status,
    int user,
    int washingTemp,
    String carNumber,
    int amount,
    DateTime usedDate,
    int cashier,
  }) =>
      OrderInProgress(
        id: id ?? this.id,
        created: created ?? this.created,
        status: status ?? this.status,
        user: user ?? this.user,
        washingTemp: washingTemp ?? this.washingTemp,
        carNumber: carNumber ?? this.carNumber,
        amount: amount ?? this.amount,
        usedDate: usedDate ?? this.usedDate,
        cashier: cashier ?? this.cashier,
      );

  factory OrderInProgress.fromJson(Map<String, dynamic> json) => OrderInProgress(
        id: json["id"],
        created: DateTime.parse(json["created"]),
        status: json["status"],
        user: json["user"],
        washingTemp: json["washing_temp"],
        carNumber: json["car_number"],
        amount: json["amount"],
        usedDate: json["used_date"],
        cashier: json["cashier"],
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? null,
        "created": created ?? null,
        "status": status ?? null,
        "user": user ?? null,
        "washing_temp": washingTemp ?? null,
        "car_number": carNumber ?? null,
        "amount": amount ?? amount,
        "used_date": usedDate ?? null,
        "cashier": cashier ?? null,
      };
}
