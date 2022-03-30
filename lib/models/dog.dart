import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'dog.g.dart';

@HiveType(typeId: 1)
class Dog extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late DateTime birthday;

  @HiveField(2)
  late String breed;

  @HiveField(3)
  late String image;
}
