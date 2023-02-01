import 'package:flutter/material.dart';
import 'package:pocker_score/models/game/game_model.dart';
import 'package:pocker_score/models/game/round_model.dart';
import 'package:pocker_score/services/game_service.dart';
import 'package:pocker_score/views/widget/add_game_dialog.dart';

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
    });
  }

  @override
  void initState() {
    super.initState();
    getGame();
  }

  List<Widget> _buildGameList(GameModel game, bool isGrey) {
    final List<Widget> list = [];
    for (var element in game.scores) {
      list.add(
        Expanded(
          flex: 1,
          child: Text(
            element.toString(),
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return list;
  }

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
              setState(() {
                isHidePoint = !isHidePoint;
              });
            },
            icon: const Icon(Icons.remove_red_eye_outlined),
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
}
