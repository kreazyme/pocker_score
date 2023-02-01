import 'package:hive/hive.dart';

part 'game_model.g.dart';

@HiveType(typeId: 0)
class GameModel {
  GameModel({
    required this.scores,
    required this.note,
    required this.isDeleted,
  });

  @HiveField(0)
  List<int> scores;

  @HiveField(1)
  String note;

  @HiveField(2)
  final bool isDeleted;

  factory GameModel.fromJson(Map<String, dynamic> json) => GameModel(
        scores: List<int>.from(json["scores"].map((x) => x)),
        note: json["note"],
        isDeleted: json["isDeleted"],
      );

  factory GameModel.initial() => GameModel(
        scores: [],
        note: "",
        isDeleted: false,
      );
}
