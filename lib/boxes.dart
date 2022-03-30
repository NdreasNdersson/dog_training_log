import 'package:dog_training_log/models/dog.dart';
import 'package:hive/hive.dart';
import 'package:dog_training_log/models/activity.dart';

class Boxes {
  static Box<Activity> getActivities() => Hive.box<Activity>('activities');
  static Box<Dog> getDogs() => Hive.box<Dog>('dogs');
}
