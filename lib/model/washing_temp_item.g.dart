// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'washing_temp_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WashingTempItemAdapter extends TypeAdapter<WashingTempItem> {
  @override
  final int typeId = 15;

  @override
  WashingTempItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WashingTempItem(
      id: fields[0] as int,
      created: fields[1] as DateTime,
      count: fields[2] as int,
      amount: fields[3] as double,
      washingTemp: fields[4] as int,
      service: fields[5] as int,
      serviceItem: fields[6] as Service,
    );
  }

  @override
  void write(BinaryWriter writer, WashingTempItem obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.created)
      ..writeByte(2)
      ..write(obj.count)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.washingTemp)
      ..writeByte(5)
      ..write(obj.service)
      ..writeByte(6)
      ..write(obj.serviceItem);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WashingTempItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
