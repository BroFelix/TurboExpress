import 'package:hive/hive.dart';
import 'package:turbo_express/model/service.dart';

part 'user_wash_item.g.dart';

@HiveType(typeId: 12)
class UserWashItem {
  @HiveField(0)
  int id;
  @HiveField(1)
  String created;
  @HiveField(2)
  int userWash;
  @HiveField(3)
  int service;
  @HiveField(4)
  int count;
  @HiveField(5)
  int amount;
  @HiveField(6)
  Service serviceItem;

  UserWashItem({this.id, this.created, this.userWash, this.service, this.count, this.amount, this.serviceItem});

  UserWashItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    userWash = json['user_wash'];
    service = json['service'];
    count = json['count'];
    amount = json['amount'];
    serviceItem = json['service_item'] != null ? new Service.fromJson(json['service_item']) : null;
  }

  Map<String, dynamic> toJson() => {
        // 'id': this.id ?? null,
        // 'created': this.created ?? null,
        'user_wash': this.userWash ?? null,
        'service': this.service ?? null,
        'count': this.count ?? null,
        'amount': this.amount ?? null,
        'service_item': this.serviceItem != null ? this.serviceItem.toJson() : null,
      };
}
