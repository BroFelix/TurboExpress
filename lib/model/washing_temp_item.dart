import 'package:hive/hive.dart';
import 'package:turbo_express/model/service.dart';

part 'washing_temp_item.g.dart';

@HiveType(typeId: 15)
class WashingTempItem {
  WashingTempItem({
    this.id,
    this.created,
    this.count,
    this.amount,
    this.washingTemp,
    this.service,
    this.serviceItem,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  DateTime created;
  @HiveField(2)
  int count;
  @HiveField(3)
  double amount;
  @HiveField(4)
  int washingTemp;
  @HiveField(5)
  int service;
  @HiveField(6)
  Service serviceItem;

  WashingTempItem copyWith({
    int id,
    DateTime created,
    int count,
    int amount,
    int washingTemp,
    int service,
    Service serviceItem,
  }) =>
      WashingTempItem(
        id: id ?? this.id,
        created: created ?? this.created,
        count: count ?? this.count,
        amount: amount ?? this.amount,
        washingTemp: washingTemp ?? this.washingTemp,
        service: service ?? this.service,
        serviceItem: serviceItem ?? this.serviceItem,
      );

  factory WashingTempItem.fromJson(Map<String, dynamic> json) => WashingTempItem(
        id: json["id"] == null ? null : json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        count: json["count"] == null ? null : json["count"],
        amount: json["amount"] == null ? null : json["amount"],
        washingTemp: json["washing_temp"] == null ? null : json["washing_temp"],
        service: json["service"] == null ? null : json["service"],
        serviceItem: json["service_item"] == null ? null : Service.fromJson(json["service_item"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "created": created == null
            ? null
            : "${created.year.toString().padLeft(4, '0')}-${created.month.toString().padLeft(2, '0')}-${created.day.toString().padLeft(2, '0')}",
        "count": count == null ? null : count,
        "amount": amount == null ? null : amount,
        "washing_temp": washingTemp == null ? null : washingTemp,
        "service": service == null ? null : service,
        "service_item": serviceItem == null ? null : serviceItem.toJson(),
      };
}
