import 'package:hive/hive.dart';
import 'package:turbo_express/model/user.dart';
import 'package:turbo_express/model/user_wash_item.dart';

part 'user_wash.g.dart';

@HiveType(typeId: 11)
class UserWash {
  @HiveField(0)
  int id;
  @HiveField(1)
  String created;
  @HiveField(2)
  String title;
  @HiveField(3)
  int status;
  @HiveField(4)
  bool isDefault;
  @HiveField(5)
  int user;
  @HiveField(6)
  int washing;
  @HiveField(7)
  List<UserWashItem> userWashItem;

  UserWash({
    this.id,
    this.created,
    this.title,
    this.status,
    this.isDefault,
    this.user,
    this.washing,
    this.userWashItem,
  });

  UserWash.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    title = json['title'];
    status = json['status'];
    isDefault = json['is_default'];
    user = json['user'];
    washing = json['washing'];
    if (json['user_wash_item'] != null) {
      userWashItem = [];
      json['user_wash_item'].forEach((v) {
        userWashItem.add(new UserWashItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() => {
        // 'id': this.id ?? null,
        // 'created': this.created ?? null,
        'title': this.title ?? null,
        'status': this.status,
        'is_default': this.isDefault,
        'user': this.user != null ? this.user : null,
        'washing': this.washing
        // 'user_wash_item': this.userWashItem != null ? this.userWashItem.map((v) => v.toJson()).toList() : null,
      };
}
