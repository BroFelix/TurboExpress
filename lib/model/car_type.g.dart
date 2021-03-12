// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarTypeAdapter extends TypeAdapter<CarType> {
  @override
  final int typeId = 2;

  @override
  CarType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarType(
      id: fields[0] as int,
      image: fields[1] as String,
      titleRu: fields[2] as String,
      titleEn: fields[3] as String,
      titleUz: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CarType obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.titleRu)
      ..writeByte(3)
      ..write(obj.titleEn)
      ..writeByte(4)
      ..write(obj.titleUz);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
