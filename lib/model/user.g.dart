// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 9;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int,
      created: fields[1] as DateTime,
      avatar: fields[2] as String,
      updated: fields[3] as DateTime,
      username: fields[4] as String,
      fullname: fields[5] as String,
      smsVerify: fields[6] as int,
      smsLive: fields[7] as bool,
      cardNumber: fields[8] as String,
      lang: fields[9] as String,
      balance: fields[10] as int,
      status: fields[11] as int,
      password: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.created)
      ..writeByte(2)
      ..write(obj.avatar)
      ..writeByte(3)
      ..write(obj.updated)
      ..writeByte(4)
      ..write(obj.username)
      ..writeByte(5)
      ..write(obj.fullname)
      ..writeByte(6)
      ..write(obj.smsVerify)
      ..writeByte(7)
      ..write(obj.smsLive)
      ..writeByte(8)
      ..write(obj.cardNumber)
      ..writeByte(9)
      ..write(obj.lang)
      ..writeByte(10)
      ..write(obj.balance)
      ..writeByte(11)
      ..write(obj.status)
      ..writeByte(12)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
