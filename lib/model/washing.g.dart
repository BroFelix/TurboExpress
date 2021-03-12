// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'washing.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WashingAdapter extends TypeAdapter<Washing> {
  @override
  final int typeId = 13;

  @override
  Washing read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Washing(
      id: fields[0] as int,
      created: fields[1] as DateTime,
      titleRu: fields[2] as String,
      titleUz: fields[3] as String,
      titleEn: fields[4] as String,
      status: fields[5] as int,
      washingTempItem: (fields[6] as List)?.cast<WashingTempItem>(),
      total: fields[7] as int,
      icon: fields[8] as String,
      image: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Washing obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.created)
      ..writeByte(2)
      ..write(obj.titleRu)
      ..writeByte(3)
      ..write(obj.titleUz)
      ..writeByte(4)
      ..write(obj.titleEn)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.washingTempItem)
      ..writeByte(7)
      ..write(obj.total)
      ..writeByte(8)
      ..write(obj.icon)
      ..writeByte(9)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WashingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
