

import '../models/activity.dart';

class Utils {
  static List<Activity> getMockedActivities() {
    return [
      Activity(type: 'Sök', distance: 50.0, date: DateTime.parse('2022-02-10'), comment: 'Det gick väldigt fort'),
      Activity(type: 'Lydnad', date: DateTime.parse('2022-02-15'), comment: 'Han fattade ingenting'),
      Activity(type: 'Sök', distance: 75.0, date: DateTime.parse('2022-02-18'), comment: 'Han slog en kullerbytta'),
    ];
  }
}