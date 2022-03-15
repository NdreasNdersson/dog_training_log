import 'package:dog_training_log/boxes.dart';
import 'package:dog_training_log/extensions/datetime.dart';
import 'package:dog_training_log/models/activity.dart';
import 'package:dog_training_log/widgets/activitycard.dart';
import 'package:dog_training_log/widgets/bottombar.dart';
import 'package:dog_training_log/widgets/headerbar.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final ValueNotifier<List<Activity>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getActivitiesForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Activity> _getActivitiesForDay(DateTime day) {
    return Boxes.getActivities()
        .values
        .where((activity) => activity.date.isSameDate(day))
        .toList();
  }

  List<Activity> _getActivitiesForRange(DateTime start, DateTime end) {
    final daysToGenerate = end.difference(start).inDays + 1;
    final days = List.generate(daysToGenerate,
        (i) => DateTime(start.year, start.month, start.day + (i)));

    return [
      for (final d in days) ..._getActivitiesForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getActivitiesForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getActivitiesForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getActivitiesForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getActivitiesForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer(),
        appBar: const HeaderBar('Calendar Page'),
        body: Column(children: [
          TableCalendar<Activity>(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getActivitiesForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: const CalendarStyle(
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Activity>>(
              valueListenable: _selectedEvents,
              builder: (context, activities, _) {
                return ListView.builder(
                  itemCount: activities.length,
                  itemBuilder: (context, index) {
                    return ActivityCard(activity: activities[index]);
                  },
                );
              },
            ),
          ),
        ]),
        bottomNavigationBar: const BottomBar());
  }
}
