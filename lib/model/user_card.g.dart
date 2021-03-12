// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserCardAdapter extends TypeAdapter<UserCard> {
  @override
  final int typeId = 10;

  @override
  UserCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserCard(
      id: fields[0] as int,
      beginDate: fields[1] as DateTime,
      endDate: fields[2] as DateTime,
      cardNumber: fields[3] as String,
      discountAmount: fields[4] as double,
      status: fields[5] as int,
      user: fields[6] as int,
      cardType: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserCard obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.beginDate)
      ..writeByte(2)
      ..write(obj.endDate)
      ..writeByte(3)
      ..write(obj.cardNumber)
      ..writeByte(4)
      ..write(obj.discountAmount)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.user)
      ..writeByte(7)
      ..write(obj.cardType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
