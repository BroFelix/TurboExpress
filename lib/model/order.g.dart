// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderAdapter extends TypeAdapter<Order> {
  @override
  final int typeId = 5;

  @override
  Order read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Order(
      id: fields[0] as int,
      created: fields[1] as DateTime,
      startTime: fields[2] as DateTime,
      endTime: fields[3] as DateTime,
      status: fields[4] as int,
      amount: fields[5] as int,
      isGuest: fields[6] as bool,
      guestCarNumber: fields[7] as String,
      boxNumb: fields[8] as int,
      car: fields[9] as int,
      carItem: fields[10] as Car,
      washing: fields[11] as int,
      washingItem: fields[12] as WashingItem,
      user: fields[13] as int,
      userItem: fields[14] as User,
      orderWashItem: (fields[15] as List)?.cast<OrderWashItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, Order obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.created)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
      ..write(obj.endTime)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.amount)
      ..writeByte(6)
      ..write(obj.isGuest)
      ..writeByte(7)
      ..write(obj.guestCarNumber)
      ..writeByte(8)
      ..write(obj.boxNumb)
      ..writeByte(9)
      ..write(obj.car)
      ..writeByte(10)
      ..write(obj.carItem)
      ..writeByte(11)
      ..write(obj.washing)
      ..writeByte(12)
      ..write(obj.washingItem)
      ..writeByte(13)
      ..write(obj.user)
      ..writeByte(14)
      ..write(obj.userItem)
      ..writeByte(15)
      ..write(obj.orderWashItem);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
