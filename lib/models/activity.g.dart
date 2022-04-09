// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivityAdapter extends TypeAdapter<Activity> {
  @override
  final int typeId = 0;

  @override
  Activity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Activity()
      ..created = fields[0] as DateTime
      ..type = fields[1] as String
      ..distance = fields[2] as double
      ..date = fields[3] as DateTime
      ..comment = fields[4] as String
      ..dog = fields[5] as Dog
      ..lineDetails = (fields[6] as List).cast<PolylineDetails>()
      ..markerDetails = (fields[7] as List).cast<MarkerDetails>();
  }

  @override
  void write(BinaryWriter writer, Activity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.created)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.distance)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.comment)
      ..writeByte(5)
      ..write(obj.dog)
      ..writeByte(6)
      ..write(obj.lineDetails)
      ..writeByte(7)
      ..write(obj.markerDetails);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
