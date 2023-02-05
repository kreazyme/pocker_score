import 'package:hive/hive.dart';
import 'package:pocker_score/models/game/game_model.dart';
import 'package:pocker_score/models/game/round_model.dart';

class GameService {
  Future<RoundModel> getDetailRound(int index) async {
    final result = await Hive.box("game").get("rounds") as List;
    return result[index];
  }

  Future<void> newGame(GameModel game, int index) async {
    final db = await Hive.box("game").get("rounds") as List;
    final round = db[index] as RoundModel;
    round.games.add(game);
    await Hive.box("game").put("rounds", db);
  }

  Future<void> updateGame(GameModel game, int roundIndex, int gameIndex) async {
    final db = await Hive.box("game").get("rounds") as List;
    final round = db[roundIndex] as RoundModel;
    round.games[gameIndex] = game;
    await Hive.box("game").put("rounds", db);
  }
}
