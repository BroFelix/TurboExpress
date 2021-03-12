// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'category.g.dart';

List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 3)
class Category {
  Category({
    this.id,
    this.title,
    this.titleRu,
    this.titleUz,
    this.titleEn,
    this.status,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String titleRu;
  @HiveField(3)
  String titleUz;
  @HiveField(4)
  String titleEn;
  @HiveField(5)
  int status;

  Category copyWith({
    int id,
    String title,
    String titleRu,
    String titleUz,
    String titleEn,
    int status,
  }) =>
      Category(
        id: id ?? this.id,
        title: title ?? this.title,
        titleRu: titleRu ?? this.titleRu,
        titleUz: titleUz ?? this.titleUz,
        titleEn: titleEn ?? this.titleEn,
        status: status ?? this.status,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: json["title"],
        titleRu: json["title_ru"],
        titleUz: json["title_uz"],
        titleEn: json["title_en"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "title_ru": titleRu,
        "title_uz": titleUz,
        "title_en": titleEn,
        "status": status,
      };
}
