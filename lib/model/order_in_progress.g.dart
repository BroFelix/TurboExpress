// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_in_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderInProgressAdapter extends TypeAdapter<OrderInProgress> {
  @override
  final int typeId = 6;

  @override
  OrderInProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderInProgress(
      id: fields[0] as int,
      created: fields[1] as DateTime,
      status: fields[2] as int,
      user: fields[3] as int,
      washingTemp: fields[4] as int,
      carNumber: fields[5] as String,
      amount: fields[6] as double,
      usedDate: fields[7] as DateTime,
      cashier: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, OrderInProgress obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.created)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.user)
      ..writeByte(4)
      ..write(obj.washingTemp)
      ..writeByte(5)
      ..write(obj.carNumber)
      ..writeByte(6)
      ..write(obj.amount)
      ..writeByte(7)
      ..write(obj.usedDate)
      ..writeByte(8)
      ..write(obj.cashier);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderInProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
