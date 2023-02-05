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
    required this.pointLimit,
    required this.gameLimit,
    required this.isHidePoint,
    required this.gameName,
  });

  RoundModel.initial()
      : games = [],
        players = [],
        pointLimit = -1,
        gameLimit = -1,
        isHidePoint = false,
        createTime = DateTime.now(),
        gameName = "Game";

  @HiveField(0)
  List<GameModel> games;

  @HiveField(1)
  final List<PlayerModel> players;

  @HiveField(2)
  final DateTime createTime;

  @HiveField(3)
  int pointLimit;

  @HiveField(4)
  int gameLimit;

  @HiveField(5)
  bool isHidePoint;

  @HiveField(6)
  String gameName;
}
