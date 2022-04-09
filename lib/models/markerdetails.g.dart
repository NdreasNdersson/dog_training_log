// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'markerdetails.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MarkerDetailsAdapter extends TypeAdapter<MarkerDetails> {
  @override
  final int typeId = 3;

  @override
  MarkerDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MarkerDetails()
      ..lat = (fields[0] as List).cast<double>()
      ..long = (fields[1] as List).cast<double>();
  }

  @override
  void write(BinaryWriter writer, MarkerDetails obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.lat)
      ..writeByte(1)
      ..write(obj.long);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarkerDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
