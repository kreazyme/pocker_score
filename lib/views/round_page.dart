import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:pocker_score/models/game/round_model.dart';
import 'package:pocker_score/services/round_service.dart';
import 'package:pocker_score/views/game_page.dart';
import 'package:pocker_score/views/widget/add_round_dialog.dart';

class RoundPage extends StatefulWidget {
  const RoundPage({super.key});

  @override
  State<RoundPage> createState() => _RoundPageState();
}

class _RoundPageState extends State<RoundPage> {
  List<RoundModel> rounds = [];

  Future<void> getListRounds() async {
    List<RoundModel> result;
    try {
      result = await RoundService().getRounds();
    } catch (e) {
      result = [];
    }
    setState(() {
      rounds = result;
    });
  }

  @override
  void initState() {
    super.initState();
    getListRounds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rounds"),
        elevation: 2,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddRoundDialog,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: getListRounds,
        child: Container(
          child: rounds.isEmpty
              ? const Center(
                  child: Text(
                    "(>'-'<)\nNo match found!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30),
                  ),
                )
              : ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GamePage(gameIndex: index),
                        )),
                    title: Text("${rounds[index].players.length} players"),
                    subtitle: Text(GetTimeAgo.parse(rounds[index].createTime)),
                    trailing: MaterialButton(
                      onPressed: () {
                        showDeleteConfirm(index);
                      },
                      child: const Icon(Icons.close),
                    ),
                  ),
                  itemCount: rounds.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
        ),
      ),
    );
  }

  void _showAddRoundDialog() {
    showDialog(
      context: context,
      builder: (context) =>
          AddRoundDialog(onDone: getListRounds, gameIndex: rounds.length),
    );
  }

  void showDeleteConfirm(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete this rounds?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              RoundService().deleteRound(index);
              getListRounds();
              Navigator.of(context).pop();
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
