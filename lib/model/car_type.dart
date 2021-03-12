// To parse this JSON data, do
//
//     final carType = carTypeFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'car_type.g.dart';

List<CarType> carTypeFromJson(String str) => List<CarType>.from(json.decode(str).map((x) => CarType.fromJson(x)));

String carTypeToJson(List<CarType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 2)
class CarType {
  CarType({
    this.id,
    this.image,
    this.titleRu,
    this.titleEn,
    this.titleUz,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  String image;
  @HiveField(2)
  String titleRu;
  @HiveField(3)
  String titleEn;
  @HiveField(4)
  String titleUz;

  CarType copyWith({
    int id,
    String image,
    String titleRu,
    String titleEn,
    String titleUz,
  }) =>
      CarType(
        id: id ?? this.id,
        image: image ?? this.image,
        titleRu: titleRu ?? this.titleRu,
        titleEn: titleEn ?? this.titleEn,
        titleUz: titleUz ?? this.titleUz,
      );

  factory CarType.fromJson(Map<String, dynamic> json) => CarType(
        id: json["id"],
        image: json["image"],
        titleRu: json["title_ru"],
        titleEn: json["title_en"],
        titleUz: json["title_uz"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "title_ru": titleRu,
        "title_en": titleEn,
        "title_uz": titleUz,
      };
}
