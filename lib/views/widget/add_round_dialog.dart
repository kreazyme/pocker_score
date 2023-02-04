// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pocker_score/models/PlayerModel.dart';
import 'package:pocker_score/models/game/round_model.dart';
import 'package:pocker_score/services/round_service.dart';
import 'package:pocker_score/views/game_page.dart';

class AddRoundDialog extends StatefulWidget {
  AddRoundDialog({super.key, required this.onDone, required this.gameIndex});

  Function onDone;
  final int gameIndex;

  @override
  State<AddRoundDialog> createState() => _AddRoundDialogState();
}

class _AddRoundDialogState extends State<AddRoundDialog> {
  List<PlayerModel> players = [];

  void _initPlayer() {
    setState(() {
      players.addAll([
        PlayerModel(name: "Player 1"),
        PlayerModel(name: "Player 2"),
      ]);
    });
  }

  void _addPlayer() {
    setState(() {
      players.add(PlayerModel(
        name: "Player ${players.length + 1}",
      ));
    });
  }

  void _editPlayer(int index, String value) {
    setState(() {
      players[index].name = value;
    });
  }

  void _newRound(context) {
    RoundModel round = RoundModel(
      players: players,
      createTime: DateTime.now(),
      games: [],
      pointLimit: -1,
      gameLimit: -1,
      isHidePoint: false,
    );
    RoundService().newRound(round);
    Navigator.of(context).pop();
    widget.onDone();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GamePage(gameIndex: widget.gameIndex),
        ));
  }

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: players.every((element) => element.name.isNotEmpty)
              ? () => _newRound(context)
              : null,
          child: const Text("OK"),
        ),
      ],
      title: const Text("Thêm người chơi"),
      content: SizedBox(
        width: width * 0.8,
        child: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: TextField(
                    onChanged: (value) => _editPlayer(index, value),
                    decoration: InputDecoration(
                      hintText: players[index].name,
                      border: InputBorder.none,
                    ),
                  ),
                  leading: Container(
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: players[index].color,
                    ),
                    child: Center(
                      child: Text(
                        players[index].name.isEmpty
                            ? "P"
                            : players[index].name[0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  trailing: MaterialButton(
                    shape: const CircleBorder(),
                    onPressed: () {
                      setState(() {
                        players.removeAt(index);
                      });
                    },
                    child: const Icon(Icons.close),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => const Divider(
                height: 2,
                color: Colors.transparent,
              ),
              itemCount: players.length,
            ),
            Container(
              child: players.length < 6
                  ? ListTile(
                      onTap: _addPlayer,
                      title: const Text("Thêm người chơi"),
                      leading: const Icon(Icons.add),
                    )
                  : Container(),
            ),
            Container(
              child: players.every((element) => element.name.isNotEmpty)
                  ? Container()
                  : Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.pink[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text("Nhập đầy đủ tên người chơi!"),
                    ),
            )
          ],
        )),
      ),
    );
  }
}

Color getRandomColor() {
  return Colors.primaries[Random().nextInt(Colors.primaries.length)];
}
