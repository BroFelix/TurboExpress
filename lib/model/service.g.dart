// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceAdapter extends TypeAdapter<Service> {
  @override
  final int typeId = 8;

  @override
  Service read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Service(
      id: fields[0] as int,
      category: fields[1] as int,
      categoryItem: fields[2] as Category,
      image: fields[3] as String,
      price: fields[4] as double,
      titleRu: fields[5] as String,
      titleUz: fields[6] as String,
      titleEn: fields[7] as String,
      descriptionRu: fields[8] as String,
      descriptionUz: fields[9] as String,
      descriptionEn: fields[10] as String,
      status: fields[11] as int,
      time: fields[12] as int,
      stage: fields[13] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Service obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.categoryItem)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.titleRu)
      ..writeByte(6)
      ..write(obj.titleUz)
      ..writeByte(7)
      ..write(obj.titleEn)
      ..writeByte(8)
      ..write(obj.descriptionRu)
      ..writeByte(9)
      ..write(obj.descriptionUz)
      ..writeByte(10)
      ..write(obj.descriptionEn)
      ..writeByte(11)
      ..write(obj.status)
      ..writeByte(12)
      ..write(obj.time)
      ..writeByte(13)
      ..write(obj.stage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
