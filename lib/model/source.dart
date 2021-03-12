// To parse this JSON data, do
//
//     final source = sourceFromJson(jsonString);

import 'dart:convert';

import 'package:turbo_express/model/car_type.dart';
import 'package:turbo_express/model/category.dart';
import 'package:turbo_express/model/news.dart';
import 'package:turbo_express/model/service.dart';
import 'package:turbo_express/model/washing.dart';

Source sourceFromJson(String str) => Source.fromJson(json.decode(str));

String sourceToJson(Source data) => json.encode(data.toJson());

class Source {
  Source({
    this.category,
    this.services,
    this.carTypes,
    this.washings,
    this.news,
  });

  List<Category> category;
  List<Service> services;
  List<CarType> carTypes;
  List<Washing> washings;
  List<News> news;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        category:
            json["category"] == null ? null : List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
        services:
            json["services"] == null ? null : List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
        carTypes:
            json["car_types"] == null ? null : List<CarType>.from(json["car_types"].map((x) => CarType.fromJson(x))),
        washings:
            json["washings"] == null ? null : List<Washing>.from(json["washings"].map((x) => Washing.fromJson(x))),
        news: json["news"] == null ? null : List<News>.from(json["news"].map((x) => News.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": category == null ? null : List<dynamic>.from(category.map((x) => x.toJson())),
        "services": services == null ? null : List<dynamic>.from(services.map((x) => x.toJson())),
        "car_types": carTypes == null ? null : List<dynamic>.from(carTypes.map((x) => x.toJson())),
        "washings": washings == null ? null : List<dynamic>.from(washings.map((x) => x.toJson())),
        "news": news == null ? null : List<dynamic>.from(news.map((x) => x.toJson())),
      };
}
