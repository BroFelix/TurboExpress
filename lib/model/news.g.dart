// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsAdapter extends TypeAdapter<News> {
  @override
  final int typeId = 4;

  @override
  News read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return News(
      status: fields[0] as int,
      image: fields[1] as String,
      titleRu: fields[2] as String,
      titleEn: fields[3] as String,
      titleUz: fields[4] as String,
      shortRu: fields[5] as String,
      shortEn: fields[6] as String,
      shortUz: fields[7] as String,
      contentRu: fields[8] as String,
      contentEn: fields[9] as String,
      contentUz: fields[10] as String,
      categoryRu: fields[11] as String,
      categoryEn: fields[12] as String,
      categoryUz: fields[13] as String,
      created: fields[14] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, News obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.titleRu)
      ..writeByte(3)
      ..write(obj.titleEn)
      ..writeByte(4)
      ..write(obj.titleUz)
      ..writeByte(5)
      ..write(obj.shortRu)
      ..writeByte(6)
      ..write(obj.shortEn)
      ..writeByte(7)
      ..write(obj.shortUz)
      ..writeByte(8)
      ..write(obj.contentRu)
      ..writeByte(9)
      ..write(obj.contentEn)
      ..writeByte(10)
      ..write(obj.contentUz)
      ..writeByte(11)
      ..write(obj.categoryRu)
      ..writeByte(12)
      ..write(obj.categoryEn)
      ..writeByte(13)
      ..write(obj.categoryUz)
      ..writeByte(14)
      ..write(obj.created);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
