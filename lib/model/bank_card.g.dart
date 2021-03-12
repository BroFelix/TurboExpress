// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BankCardAdapter extends TypeAdapter<BankCard> {
  @override
  final int typeId = 0;

  @override
  BankCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BankCard(
      id: fields[0] as int,
      created: fields[1] as DateTime,
      pan: fields[2] as String,
      expireDate: fields[3] as int,
      cardName: fields[4] as String,
      fullName: fields[5] as String,
      cardType: fields[6] as int,
      isMain: fields[7] as bool,
      user: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, BankCard obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.created)
      ..writeByte(2)
      ..write(obj.pan)
      ..writeByte(3)
      ..write(obj.expireDate)
      ..writeByte(4)
      ..write(obj.cardName)
      ..writeByte(5)
      ..write(obj.fullName)
      ..writeByte(6)
      ..write(obj.cardType)
      ..writeByte(7)
      ..write(obj.isMain)
      ..writeByte(8)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
