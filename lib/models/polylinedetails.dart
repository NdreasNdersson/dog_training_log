import 'package:hive/hive.dart';

part 'polylinedetails.g.dart';

@HiveType(typeId: 2)
class PolylineDetails extends HiveObject {
  @HiveField(0)
  List<double> lat = [];

  @HiveField(1)
  List<double> long = [];

  @HiveField(2)
  int color = 0;
}
