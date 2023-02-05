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
      pointLimit: fields[3] as int,
      gameLimit: fields[4] as int,
      isHidePoint: fields[5] as bool,
      gameName: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RoundModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.games)
      ..writeByte(1)
      ..write(obj.players)
      ..writeByte(2)
      ..write(obj.createTime)
      ..writeByte(3)
      ..write(obj.pointLimit)
      ..writeByte(4)
      ..write(obj.gameLimit)
      ..writeByte(5)
      ..write(obj.isHidePoint)
      ..writeByte(6)
      ..write(obj.gameName);
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
