import 'package:flutter/material.dart';
import 'package:pocker_score/services/round_service.dart';

class SettingDialog extends StatefulWidget {
  const SettingDialog({
    super.key,
    required this.gameIndex,
    required this.onDone,
    required this.gameLimit,
    required this.pointLimit,
  });

  final int gameIndex;
  final Function onDone;
  final int gameLimit;
  final int pointLimit;

  @override
  State<SettingDialog> createState() => _SettingDialogState();
}

class _SettingDialogState extends State<SettingDialog> {
  final TextEditingController _controller = TextEditingController();
  bool isPoint = false;
  bool isGame = false;
  int limit = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(textListener);
    setState(() {
      isPoint = widget.pointLimit > 0;
      isGame = widget.gameLimit > 0;
      _controller.text =
          isPoint ? widget.pointLimit.toString() : widget.gameLimit.toString();
    });
  }

  void textListener() {
    if (_controller.text.length > 3) {
      _controller.text = _controller.text.substring(0, 3);
      _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
      return;
    }
    setState(() {
      limit = int.tryParse(_controller.text) ?? 0;
    });
  }

  void setLimit() {
    if (isPoint) {
      RoundService().onChangePointLimit(widget.gameIndex, limit);
    } else if (isGame) {
      RoundService().onChangeGameLimit(widget.gameIndex, limit);
    }
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text("Setting"),
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: isPoint,
                      onChanged: (value) => setState(() {
                        isPoint = value!;
                        if (isPoint) isGame = false;
                      }),
                    ),
                    const Text("Limit max points")
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isGame,
                      onChanged: (value) => setState(() {
                        isGame = value!;
                        if (isGame) isPoint = false;
                      }),
                    ),
                    const Text("Limit max games")
                  ],
                ),
              ],
            ),
            Container(
                child: isGame == true || isPoint == true
                    ? Container(
                        margin: const EdgeInsets.only(left: 20),
                        width: 100,
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: "0",
                          ),
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : const SizedBox(
                        height: 1,
                        width: 120,
                      )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => (isGame == true || isPoint == true) && limit > 0
                ? {setLimit(), Navigator.pop(context)}
                : {},
            child: Text(
              "OK",
              style: TextStyle(
                color: (isGame == true || isPoint == true) && limit > 0
                    ? null
                    : Colors.grey,
              ),
            ),
          ),
        ],
      );
}
