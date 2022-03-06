import 'package:hive/hive.dart';

part 'activity.g.dart';

@HiveType(typeId: 0)
class Activity extends HiveObject {
  @HiveField(0)
  late DateTime created;

  @HiveField(1)
  late String type;

  @HiveField(2)
  late double distance;

  @HiveField(3)
  late DateTime date;

  @HiveField(4)
  late String comment;
}
