import 'package:hive/hive.dart';
import 'package:pocker_score/models/game/game_model.dart';

import '../PlayerModel.dart';

part 'round_model.g.dart';

@HiveType(typeId: 1)
class RoundModel {
  RoundModel({
    required this.games,
    required this.players,
    required this.createTime,
  });

  RoundModel.initial()
      : games = [],
        players = [],
        createTime = DateTime.now();

  @HiveField(0)
  List<GameModel> games;

  @HiveField(1)
  final List<PlayerModel> players;

  @HiveField(2)
  final DateTime createTime;

  

  factory RoundModel.fromJson(Map<String, dynamic> json) => RoundModel(
        games: List<GameModel>.from(
            json["games"].map((x) => GameModel.fromJson(x))),
        players: List<PlayerModel>.from(
            json["players"].map((x) => PlayerModel.fromJson(x))),
        createTime: DateTime.parse(json["createTime"]),
      );
}
