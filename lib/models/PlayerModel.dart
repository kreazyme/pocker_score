import 'dart:math';

import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

part 'PlayerModel.g.dart';

@HiveType(typeId: 2)
class PlayerModel {
  PlayerModel({
    required this.name,
  });

  @HiveField(0)
  String name;

  final Color color =
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  factory PlayerModel.fromJson(Map<String, dynamic> json) => PlayerModel(
        name: json["name"],
      );
}
