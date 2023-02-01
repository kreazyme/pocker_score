// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDBModelAdapter extends TypeAdapter<UserDBModel> {
  @override
  final int typeId = 3;

  @override
  UserDBModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDBModel(
      round: (fields[0] as List).cast<RoundModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserDBModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.round);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDBModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
