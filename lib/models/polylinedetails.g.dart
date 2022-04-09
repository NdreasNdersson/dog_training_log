// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'polylinedetails.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PolylineDetailsAdapter extends TypeAdapter<PolylineDetails> {
  @override
  final int typeId = 2;

  @override
  PolylineDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PolylineDetails()
      ..lat = (fields[0] as List).cast<double>()
      ..long = (fields[1] as List).cast<double>()
      ..color = fields[2] as int;
  }

  @override
  void write(BinaryWriter writer, PolylineDetails obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.lat)
      ..writeByte(1)
      ..write(obj.long)
      ..writeByte(2)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PolylineDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
