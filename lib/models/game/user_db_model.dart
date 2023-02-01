import 'package:hive/hive.dart';
import 'package:pocker_score/models/game/round_model.dart';

part 'user_db_model.g.dart';

@HiveType(typeId: 3)
class UserDBModel {
  UserDBModel({
    required this.round,
  });

  @HiveField(0)
  final List<RoundModel> round;
}
