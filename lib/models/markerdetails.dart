import 'package:hive/hive.dart';

part 'markerdetails.g.dart';

@HiveType(typeId: 3)
class MarkerDetails extends HiveObject {
  @HiveField(0)
  List<double> lat = [];

  @HiveField(1)
  List<double> long = [];
}
