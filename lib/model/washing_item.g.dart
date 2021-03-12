// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'washing_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WashingItemAdapter extends TypeAdapter<WashingItem> {
  @override
  final int typeId = 14;

  @override
  WashingItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WashingItem(
      id: fields[0] as int,
      created: fields[1] as DateTime,
      washingTemp: fields[2] as int,
      service: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, WashingItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.created)
      ..writeByte(2)
      ..write(obj.washingTemp)
      ..writeByte(3)
      ..write(obj.service);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WashingItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
