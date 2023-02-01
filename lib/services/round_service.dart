import 'package:hive/hive.dart';
import 'package:pocker_score/models/game/round_model.dart';

class RoundService {
  Future<List<RoundModel>> getRounds() async {
    final result = await Hive.box("game").get("rounds") as List;
    List<RoundModel> ls = [];
    for (var e in result) {
      ls.add(e);
    }
    return ls;
  }

  Future<void> newRound(RoundModel rounds) async {
    var ls;
    try {
      ls = await Hive.box("game").get("rounds") as List;
    } catch (e) {
      ls = [];
    }
    ls.add(rounds);
    await Hive.box("game").put("rounds", ls);
  }

  Future<void> deleteRounds() async {
    await Hive.box("game").delete("rounds");
  }

  Future<void> deleteRound(int index) async {
    final ls = await Hive.box("game").get("rounds") as List;
    ls.removeAt(index);
    await Hive.box("game").put("rounds", ls);
  }
}
