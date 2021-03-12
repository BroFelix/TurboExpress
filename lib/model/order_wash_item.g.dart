// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_wash_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderWashItemAdapter extends TypeAdapter<OrderWashItem> {
  @override
  final int typeId = 7;

  @override
  OrderWashItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderWashItem(
      id: fields[0] as int,
      count: fields[1] as int,
      amount: fields[2] as int,
      orderWash: fields[3] as int,
      service: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, OrderWashItem obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.count)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.orderWash)
      ..writeByte(4)
      ..write(obj.service);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderWashItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
