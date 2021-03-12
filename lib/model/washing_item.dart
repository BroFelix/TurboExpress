// To parse this JSON data, do
//
//     final washingItem = washingItemFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'washing_item.g.dart';

List<WashingItem> washingItemFromJson(String str) =>
    List<WashingItem>.from(json.decode(str).map((x) => WashingItem.fromJson(x)));

String washingItemToJson(List<WashingItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 14)
class WashingItem {
  WashingItem({
    int id,
    this.created,
    this.washingTemp,
    this.service,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  DateTime created;
  @HiveField(2)
  int washingTemp;
  @HiveField(3)
  int service;

  WashingItem copyWith({
    int id,
    DateTime created,
    int washingTemp,
    int service,
  }) =>
      WashingItem(
        id: id ?? this.id,
        created: created ?? this.created,
        washingTemp: washingTemp ?? this.washingTemp,
        service: service ?? this.service,
      );

  factory WashingItem.fromJson(Map<String, dynamic> json) => WashingItem(
        created: DateTime.parse(json["created"]),
        washingTemp: json["washing_temp"],
        service: json["service"],
      );

  Map<String, dynamic> toJson() => {
        "created":
            "${created.year.toString().padLeft(4, '0')}-${created.month.toString().padLeft(2, '0')}-${created.day.toString().padLeft(2, '0')}",
        "washing_temp": washingTemp,
        "service": service,
      };
}

enum Title { BODY, SALON, ADDITIONAL_SERVICES }

final titleValues =
    EnumValues({"Additional services": Title.ADDITIONAL_SERVICES, "Body": Title.BODY, "Salon": Title.SALON});

enum TitleRu { EMPTY, TITLE_RU, PURPLE }

final titleRuValues =
    EnumValues({"Кузов": TitleRu.EMPTY, "Дополнительные услуги": TitleRu.PURPLE, "Салон": TitleRu.TITLE_RU});

enum TitleUz { TANA, SALON, QO_SHIMCHA_XIZMATLAR }

final titleUzValues =
    EnumValues({"Qo'shimcha xizmatlar": TitleUz.QO_SHIMCHA_XIZMATLAR, "Salon": TitleUz.SALON, "Tana": TitleUz.TANA});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
