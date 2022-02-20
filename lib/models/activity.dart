import 'dart:ui';

class Activity {
  Activity({required this.type, required this.date, this.distance = 0.0, this.comment = ""});

  final created = DateTime.now();
  String type;
  double distance;
  DateTime date;
  String comment;

  toText() {
    return "Type: $type, Distance: $distance, Date: ${date.year}-${date.month}-${date.day}, Comment: $comment";
  }
}