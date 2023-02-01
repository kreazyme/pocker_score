import 'package:flutter/material.dart';

class GameItemWidget extends StatelessWidget {
  const GameItemWidget({super.key, required this.texts});

  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        for (var element in texts) {
          return Expanded(
            flex: 1,
            child: Text(element),
          );
        }
        return Container();
      },
    );
  }
}
