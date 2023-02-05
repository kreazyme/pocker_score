import 'package:hive/hive.dart';

part 'game_model.g.dart';

@HiveType(typeId: 0)
class GameModel {
  GameModel({
    required this.scores,
    required this.note,
    required this.isDeleted,
    required this.createTime,
  });

  operator +(GameModel other) {
    return GameModel(
      scores: List.generate(
        scores.length,
        (index) => scores[index] + other.scores[index],
      ),
      note: note,
      isDeleted: isDeleted,
      createTime: createTime,
    );
  }

  @HiveField(0)
  List<int> scores;

  @HiveField(1)
  String note;

  @HiveField(2)
  final bool isDeleted;

  @HiveField(3)
  final DateTime createTime;

  factory GameModel.fromJson(Map<String, dynamic> json) => GameModel(
        scores: List<int>.from(json["scores"].map((x) => x)),
        note: json["note"],
        isDeleted: json["isDeleted"],
        createTime: DateTime.parse(json["createTime"]),
      );

  factory GameModel.initial() => GameModel(
        scores: [],
        note: "",
        isDeleted: false,
        createTime: DateTime.now(),
      );
}
