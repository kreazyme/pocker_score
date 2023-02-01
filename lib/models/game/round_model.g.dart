// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'round_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoundModelAdapter extends TypeAdapter<RoundModel> {
  @override
  final int typeId = 1;

  @override
  RoundModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoundModel(
      games: (fields[0] as List).cast<GameModel>(),
      players: (fields[1] as List).cast<PlayerModel>(),
      createTime: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, RoundModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.games)
      ..writeByte(1)
      ..write(obj.players)
      ..writeByte(2)
      ..write(obj.createTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoundModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
