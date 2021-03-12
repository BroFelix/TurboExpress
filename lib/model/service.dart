import 'package:hive/hive.dart';
import 'package:turbo_express/model/category.dart';

part 'service.g.dart';

@HiveType(typeId: 8)
class Service {
  @HiveField(0)
  int id;
  @HiveField(1)
  int category;
  @HiveField(2)
  Category categoryItem;
  @HiveField(3)
  String image;
  @HiveField(4)
  double price;
  @HiveField(5)
  String titleRu;
  @HiveField(6)
  String titleUz;
  @HiveField(7)
  String titleEn;
  @HiveField(8)
  String descriptionRu;
  @HiveField(9)
  String descriptionUz;
  @HiveField(10)
  String descriptionEn;
  @HiveField(11)
  int status;
  @HiveField(12)
  int time;
  @HiveField(13)
  int stage;

  Service({
    this.id,
    this.category,
    this.categoryItem,
    this.image,
    this.price,
    this.titleRu,
    this.titleUz,
    this.titleEn,
    this.descriptionRu,
    this.descriptionUz,
    this.descriptionEn,
    this.status,
    this.time,
    this.stage,
  });

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    categoryItem = json['category_item'] != null ? new Category.fromJson(json['category_item']) : null;
    image = json['image'];
    price = json['price'];
    titleRu = json['title_ru'];
    titleUz = json['title_uz'];
    titleEn = json['title_en'];
    descriptionRu = json['description_ru'];
    descriptionUz = json['description_uz'];
    descriptionEn = json['description_en'];
    status = json['status'];
    time = json['time'];
    stage = json['stage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    if (this.categoryItem != null) {
      data['category_item'] = this.categoryItem.toJson();
    }
    data['image'] = this.image;
    data['price'] = this.price;
    data['title_ru'] = this.titleRu;
    data['title_uz'] = this.titleUz;
    data['title_en'] = this.titleEn;
    data['description_ru'] = this.descriptionRu;
    data['description_uz'] = this.descriptionUz;
    data['description_en'] = this.descriptionEn;
    data['status'] = this.status;
    data['time'] = this.time;
    data['stage'] = this.stage;
    return data;
  }
}
