import 'package:hive/hive.dart';

part 'order_wash_item.g.dart';

@HiveType(typeId: 7)
class OrderWashItem {
  OrderWashItem({
    this.id,
    this.count,
    this.amount,
    this.orderWash,
    this.service,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  int count;
  @HiveField(2)
  int amount;
  @HiveField(3)
  int orderWash;
  @HiveField(4)
  int service;

  OrderWashItem copyWith({
    int id,
    int count,
    int amount,
    int orderWash,
    int service,
  }) =>
      OrderWashItem(
        id: id ?? this.id,
        count: count ?? this.count,
        amount: amount ?? this.amount,
        orderWash: orderWash ?? this.orderWash,
        service: service ?? this.service,
      );

  factory OrderWashItem.fromJson(Map<String, dynamic> json) => OrderWashItem(
        id: json["id"] == null ? null : json["id"],
        count: json["count"] == null ? null : json["count"],
        amount: json["amount"] == null ? null : json["amount"],
        orderWash: json["order_wash"] == null ? null : json["order_wash"],
        service: json["service"] == null ? null : json["service"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "count": count == null ? null : count,
        "amount": amount == null ? null : amount,
        "order_wash": orderWash == null ? null : orderWash,
        "service": service == null ? null : service,
      };
}
