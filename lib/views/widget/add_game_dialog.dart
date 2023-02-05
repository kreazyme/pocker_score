import 'package:flutter/material.dart';
import 'package:pocker_score/models/PlayerModel.dart';
import 'package:pocker_score/models/game/game_model.dart';
import 'package:pocker_score/services/game_service.dart';

class AddGameDialog extends StatefulWidget {
  const AddGameDialog({
    super.key,
    required this.players,
    required this.gameIndex,
    required this.onDone,
    this.game,
    this.index,
  });

  final List<PlayerModel> players;
  final int gameIndex;
  final Function onDone;
  final GameModel? game;
  final int? index;

  @override
  State<AddGameDialog> createState() => _AddGameDialogState();
}

class _AddGameDialogState extends State<AddGameDialog> {
  GameModel game = GameModel.initial();

  Future<void> addGame() async {
    if (widget.game != null) {
      await GameService().updateGame(game, widget.gameIndex, widget.index!);
    } else {
      await GameService().newGame(game, widget.gameIndex);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.game != null) {
      game = widget.game!;
    } else {
      game.scores = List<int>.filled(widget.players.length, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add game"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () async {
            await addGame();
            widget.onDone();
            if (mounted) {
              Navigator.pop(context);
            }
          },
          child: const Text("Add"),
        ),
      ],
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    PlayerModel player = widget.players[index];
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: player.color,
                          ),
                          width: 40,
                          margin: const EdgeInsets.only(right: 12),
                          child: Center(
                            child: Text(
                              player.name[0].toUpperCase(),
                              style: const TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Text(player.name,
                            style: const TextStyle(fontSize: 20),
                            overflow: TextOverflow.ellipsis),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              game.scores[index]--;
                            });
                          },
                          child: const Icon(Icons.remove),
                        ),
                        Text(
                          game.scores[index].toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: game.scores[index] == 0
                                ? Colors.black
                                : game.scores[index] > 0
                                    ? Colors.green
                                    : Colors.red,
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              game.scores[index]++;
                            });
                          },
                          child: const Icon(Icons.add),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                        height: 20,
                        color: Colors.transparent,
                      ),
                  itemCount: widget.players.length),
              TextField(
                onChanged: (value) => setState(() {
                  game.note = value;
                }),
                decoration: const InputDecoration(
                  labelText: "Note",
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child:
                    game.scores.reduce((value, element) => element + value) == 0
                        ? Container()
                        : Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.pink[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text("Sum not equal to 0!"),
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
