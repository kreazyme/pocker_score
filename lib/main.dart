import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pocker_score/models/PlayerModel.dart';
import 'package:pocker_score/models/game/game_model.dart';
import 'package:pocker_score/models/game/round_model.dart';
import 'package:pocker_score/models/game/user_db_model.dart';
import 'package:pocker_score/views/round_page.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserDBModelAdapter());
  Hive.registerAdapter(RoundModelAdapter());
  Hive.registerAdapter(PlayerModelAdapter());
  Hive.registerAdapter(GameModelAdapter());
  await Hive.openBox("game");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const RoundPage(),
    );
  }
}
