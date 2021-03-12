// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
part 'news.g.dart';
List<News> newsFromJson(String str) => List<News>.from(json.decode(str).map((x) => News.fromJson(x)));

String newsToJson(List<News> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 4)
class News {
  News({
    this.status,
    this.image,
    this.titleRu,
    this.titleEn,
    this.titleUz,
    this.shortRu,
    this.shortEn,
    this.shortUz,
    this.contentRu,
    this.contentEn,
    this.contentUz,
    this.categoryRu,
    this.categoryEn,
    this.categoryUz,
    this.created,
  });

  @HiveField(0)
  int status;
  @HiveField(1)
  String image;
  @HiveField(2)
  String titleRu;
  @HiveField(3)
  String titleEn;
  @HiveField(4)
  String titleUz;
  @HiveField(5)
  String shortRu;
  @HiveField(6)
  String shortEn;
  @HiveField(7)
  String shortUz;
  @HiveField(8)
  String contentRu;
  @HiveField(9)
  String contentEn;
  @HiveField(10)
  String contentUz;
  @HiveField(11)
  String categoryRu;
  @HiveField(12)
  String categoryEn;
  @HiveField(13)
  String categoryUz;
  @HiveField(14)
  DateTime created;

  News copyWith({
    int status,
    String image,
    String titleRu,
    String titleEn,
    String titleUz,
    String shortRu,
    String shortEn,
    String shortUz,
    String contentRu,
    String contentEn,
    String contentUz,
    String categoryRu,
    String categoryEn,
    String categoryUz,
    DateTime created,
  }) =>
      News(
        status: status ?? this.status,
        image: image ?? this.image,
        titleRu: titleRu ?? this.titleRu,
        titleEn: titleEn ?? this.titleEn,
        titleUz: titleUz ?? this.titleUz,
        shortRu: shortRu ?? this.shortRu,
        shortEn: shortEn ?? this.shortEn,
        shortUz: shortUz ?? this.shortUz,
        contentRu: contentRu ?? this.contentRu,
        contentEn: contentEn ?? this.contentEn,
        contentUz: contentUz ?? this.contentUz,
        categoryRu: categoryRu ?? this.categoryRu,
        categoryEn: categoryEn ?? this.categoryEn,
        categoryUz: categoryUz ?? this.categoryUz,
        created: created ?? this.created,
      );

  factory News.fromJson(Map<String, dynamic> json) => News(
        status: json["status"],
        image: json["image"],
        titleRu: json["title_ru"],
        titleEn: json["title_en"],
        titleUz: json["title_uz"],
        shortRu: json["short_ru"],
        shortEn: json["short_en"],
        shortUz: json["short_uz"],
        contentRu: json["content_ru"],
        contentEn: json["content_en"],
        contentUz: json["content_uz"],
        categoryRu: json["category_ru"],
        categoryEn: json["category_en"],
        categoryUz: json["category_uz"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "image": image,
        "title_ru": titleRu,
        "title_en": titleEn,
        "title_uz": titleUz,
        "short_ru": shortRu,
        "short_en": shortEn,
        "short_uz": shortUz,
        "content_ru": contentRu,
        "content_en": contentEn,
        "content_uz": contentUz,
        "category_ru": categoryRu,
        "category_en": categoryEn,
        "category_uz": categoryUz,
        "created":
            "${created.year.toString().padLeft(4, '0')}-${created.month.toString().padLeft(2, '0')}-${created.day.toString().padLeft(2, '0')}",
      };
}
