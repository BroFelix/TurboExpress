// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_wash_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserWashItemAdapter extends TypeAdapter<UserWashItem> {
  @override
  final int typeId = 12;

  @override
  UserWashItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserWashItem(
      id: fields[0] as int,
      created: fields[1] as String,
      userWash: fields[2] as int,
      service: fields[3] as int,
      count: fields[4] as int,
      amount: fields[5] as int,
      serviceItem: fields[6] as Service,
    );
  }

  @override
  void write(BinaryWriter writer, UserWashItem obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.created)
      ..writeByte(2)
      ..write(obj.userWash)
      ..writeByte(3)
      ..write(obj.service)
      ..writeByte(4)
      ..write(obj.count)
      ..writeByte(5)
      ..write(obj.amount)
      ..writeByte(6)
      ..write(obj.serviceItem);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserWashItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
