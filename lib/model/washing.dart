// To parse this JSON data, do
//
//     final washing = washingFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

import 'washing_temp_item.dart';

part 'washing.g.dart';

List<Washing> washingFromJson(String str) => List<Washing>.from(json.decode(str).map((x) => Washing.fromJson(x)));

String washingToJson(List<Washing> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 13)
class Washing {
  Washing({
    this.id,
    this.created,
    this.titleRu,
    this.titleUz,
    this.titleEn,
    this.status,
    this.washingTempItem,
    this.total,
    this.icon,
    this.image,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  DateTime created;
  @HiveField(2)
  String titleRu;
  @HiveField(3)
  String titleUz;
  @HiveField(4)
  String titleEn;
  @HiveField(5)
  int status;
  @HiveField(6)
  List<WashingTempItem> washingTempItem;
  @HiveField(7)
  int total;
  @HiveField(8)
  String icon;
  @HiveField(9)
  String image;

  Washing copyWith({
    int id,
    DateTime created,
    String titleRu,
    String titleUz,
    String titleEn,
    int status,
    List<WashingTempItem> washingTempItem,
    int total,
    String icon,
    String image,
  }) =>
      Washing(
        id: id ?? this.id,
        created: created ?? this.created,
        titleRu: titleRu ?? this.titleRu,
        titleUz: titleUz ?? this.titleUz,
        titleEn: titleEn ?? this.titleEn,
        status: status ?? this.status,
        washingTempItem: washingTempItem ?? this.washingTempItem,
        total: total ?? this.total,
        icon: icon ?? this.icon,
        image: image ?? this.image,
      );

  factory Washing.fromJson(Map<String, dynamic> json) => Washing(
        id: json["id"] == null ? null : json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        titleRu: json["title_ru"] == null ? null : json["title_ru"],
        titleUz: json["title_uz"] == null ? null : json["title_uz"],
        titleEn: json["title_en"] == null ? null : json["title_en"],
        status: json["status"] == null ? null : json["status"],
        washingTempItem: json["washing_temp_item"] == null
            ? null
            : List<WashingTempItem>.from(json["washing_temp_item"].map((x) => WashingTempItem.fromJson(x))),
        total: json["total"] == null ? null : json["total"],
        icon: json["icon"] == null ? null : json["icon"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "created": created == null
            ? null
            : "${created.year.toString().padLeft(4, '0')}-${created.month.toString().padLeft(2, '0')}-${created.day.toString().padLeft(2, '0')}",
        "title_ru": titleRu == null ? null : titleRu,
        "title_uz": titleUz == null ? null : titleUz,
        "title_en": titleEn == null ? null : titleEn,
        "status": status == null ? null : status,
        "washing_temp_item":
            washingTempItem == null ? null : List<dynamic>.from(washingTempItem.map((x) => x.toJson())),
        "total": total == null ? null : total,
        "icon": icon == null ? null : icon,
        "image": image == null ? null : image,
      };
}
