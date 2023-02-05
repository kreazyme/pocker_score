import 'package:flutter/material.dart';
import 'package:pocker_score/services/round_service.dart';

class EditGameNameDialog extends StatefulWidget {
  const EditGameNameDialog({
    super.key,
    required this.gameIndex,
    required this.oldName,
  }) : assert(
          gameIndex >= 0,
          "gameIndex must be >= 0",
        );

  final int gameIndex;
  final String oldName;

  @override
  State<EditGameNameDialog> createState() => _EditGameNameDialogState();
}

class _EditGameNameDialogState extends State<EditGameNameDialog> {
  String name = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      name = widget.oldName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit game name"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            if (name.isEmpty) {
              RoundService().updateRoundName(widget.gameIndex, name);
              if (mounted) {
                Navigator.pop(context);
              }
            }
          },
          child: Text(
            "Save",
            style: TextStyle(color: name.isEmpty ? Colors.grey : null),
          ),
        ),
      ],
      content: TextField(
        decoration: InputDecoration(
          hintText: name,
          labelText: "Game name",
        ),
        onChanged: (value) => setState(() {
          name = value;
        }),
      ),
    );
  }
}
