// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_wash.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserWashAdapter extends TypeAdapter<UserWash> {
  @override
  final int typeId = 11;

  @override
  UserWash read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserWash(
      id: fields[0] as int,
      created: fields[1] as String,
      title: fields[2] as String,
      status: fields[3] as int,
      isDefault: fields[4] as bool,
      user: fields[5] as int,
      washing: fields[6] as int,
      userWashItem: (fields[7] as List)?.cast<UserWashItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserWash obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.created)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.isDefault)
      ..writeByte(5)
      ..write(obj.user)
      ..writeByte(6)
      ..write(obj.washing)
      ..writeByte(7)
      ..write(obj.userWashItem);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserWashAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
