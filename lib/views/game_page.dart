import 'package:flutter/material.dart';
import 'package:pocker_score/models/game/game_model.dart';
import 'package:pocker_score/models/game/round_model.dart';
import 'package:pocker_score/services/game_service.dart';
import 'package:pocker_score/services/round_service.dart';
import 'package:pocker_score/views/widget/add_game_dialog.dart';
import 'package:pocker_score/views/widget/setting_dialog.dart';
import 'package:pocker_score/views/widget/success_dialog.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.gameIndex});

  final int gameIndex;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  RoundModel round = RoundModel.initial();
  bool isHidePoint = false;

  Future<void> getGame() async {
    final result = await GameService().getDetailRound(widget.gameIndex);
    setState(() {
      round = result;
      isHidePoint = result.isHidePoint;
    });
    checkResult();
  }

  Future<void> onChangeHidePoint(bool value) async {
    await RoundService().onChangeHidePoint(widget.gameIndex, value);
    setState(() {
      isHidePoint = value;
    });
  }

  void checkResult() {
    if ((round.gameLimit > 0 && round.games.length >= round.gameLimit) ||
        (round.pointLimit > 0 &&
            round.games
                .reduce((value, element) => value + element)
                .scores
                .any((element) => element >= round.pointLimit))) {
      showDoneDialog();
      Navigator.push(context, GameSuccessDialog());
    }
  }

  @override
  void initState() {
    super.initState();
    getGame();
  }

  List<Widget> _buildGameList(
    GameModel game,
    bool isGrey,
  ) =>
      game.scores
          .map((element) => Expanded(
                flex: 1,
                child: Text(
                  element.toString(),
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ))
          .toList();

  List<Widget> _buildPlayerList() {
    final List<Widget> list = [];
    for (int i = 0; i < round.players.length; i++) {
      final point = round.games
          .map((e) => e.scores[i])
          .reduce((value, element) => value + element);
      list.add(
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Container(
                child: isHidePoint
                    ? Container()
                    : Container(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            point.toString(),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: point < 0 ? Colors.red : Colors.black,
                            ),
                          ),
                        ),
                      ),
              ),
              Text(
                round.players[i].name,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: showAddGameDialog,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Game page"),
        actions: [
          IconButton(
            onPressed: () {
              onChangeHidePoint(!isHidePoint);
            },
            icon: const Icon(Icons.remove_red_eye_outlined),
          ),
          IconButton(
            onPressed: showSettingDialog,
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Container(
          child: round.games.isEmpty
              ? const Center(
                  child: Text(
                    "No game found!\nKeep playing and record that ^^.",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : RefreshIndicator(
                  onRefresh: getGame,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return ListTile(
                          title: Row(
                            children: _buildPlayerList(),
                          ),
                        );
                      }
                      return ListTile(
                        title: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: index % 2 == 1
                                ? Colors.grey[200]
                                : Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            children: _buildGameList(
                              round.games[index - 1],
                              index % 2 == 1,
                            ),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            round.games[index - 1].note,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      );
                    },
                    itemCount: round.games.length + 1,
                  ),
                )),
    );
  }

  void showAddGameDialog() {
    showDialog(
      context: context,
      builder: (context) => AddGameDialog(
        gameIndex: widget.gameIndex,
        players: round.players,
        onDone: getGame,
      ),
    );
  }

  void showSettingDialog() {
    showDialog(
      context: context,
      builder: (context) => SettingDialog(
        gameIndex: widget.gameIndex,
        onDone: checkResult,
        gameLimit: round.gameLimit,
        pointLimit: round.pointLimit,
      ),
    );
  }

  void showDoneDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              showSettingDialog();
            },
            child: const Text("Setting"),
          ),
        ],
        title: const Text("^.^"),
        content: const Text(
          "Game has been stopped! Try change setting to continue",
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
