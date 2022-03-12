import 'package:dog_training_log/boxes.dart';
import 'package:dog_training_log/models/activity.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

class ActivityEntry extends StatefulWidget {
  final Activity? activity;

  const ActivityEntry({this.activity, Key? key}) : super(key: key);

  @override
  State<ActivityEntry> createState() => _ActivityEntryState();
}

class _ActivityEntryState extends State<ActivityEntry> {
  late DateTime _dateTime;

  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  var deleteCloseText = "Delete";

  @override
  void initState() {
    if (widget.activity != null) {
      _dateTime = widget.activity!.date;
      _typeController.text = widget.activity!.type;
      _distanceController.text = "${widget.activity!.distance}";
      _commentController.text = widget.activity!.comment;
    } else {
      _dateTime = DateTime.now();
      deleteCloseText = "Close";
    }
    _dateController.text = DateFormat.yMd().format(_dateTime);
    _timeController.text = formatDate(_dateTime, [HH, ':', nn]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _typeController,
          decoration: const InputDecoration(
              disabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
              labelText: 'Type',
              contentPadding: EdgeInsets.all(5)),
          minLines: 1,
        ),
        TextField(
          controller: _distanceController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              disabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
              labelText: 'Distance',
              contentPadding: EdgeInsets.all(5)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                width: 150,
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: TextFormField(
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                  enabled: false,
                  keyboardType: TextInputType.text,
                  controller: _dateController,
                  decoration: const InputDecoration(
                      disabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                      labelText: 'Date',
                      contentPadding: EdgeInsets.all(5)),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _selectTime(context);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                width: 100,
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: TextFormField(
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                  enabled: false,
                  keyboardType: TextInputType.text,
                  controller: _timeController,
                  decoration: const InputDecoration(
                      disabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                      labelText: 'Time',
                      contentPadding: EdgeInsets.all(5)),
                ),
              ),
            ),
          ],
        ),
        TextField(
          controller: _commentController,
          decoration: const InputDecoration(
              disabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
              labelText: 'Comment',
              contentPadding: EdgeInsets.all(5)),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ElevatedButton(
            onPressed: () {
              if (widget.activity != null) {
                widget.activity!.delete();
              }
              Navigator.pop(context);
            },
            child: Text(deleteCloseText),
          ),
          ElevatedButton(
            onPressed: () {
              double distance = 0.0;
              if (_distanceController.text != "") {
                distance = double.parse(_distanceController.text);
              }

              if (widget.activity != null) {
                editActivity(widget.activity!, _typeController.text, _dateTime,
                    distance, _commentController.text);
              } else {
                addActivity(_typeController.text, _dateTime, distance,
                    _commentController.text);
              }
              Navigator.pop(context);
            },
            child: const Text("Save"),
          )
        ]),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null && picked != _dateTime) {
      setState(() {
        _dateTime = picked;
        _dateController.text = DateFormat.yMd().format(_dateTime);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_dateTime),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day,
            picked.hour, picked.minute);
        _timeController.text = formatDate(_dateTime, [HH, ':', nn]).toString();
      });
    }
  }

  void editActivity(Activity activity, String type, DateTime date,
      double distance, String comment) {
    activity.type = type;
    activity.date = date;
    activity.distance = distance;
    activity.comment = comment;

    activity.save();
  }

  void addActivity(
      String type, DateTime date, double distance, String comment) {
    final activity = Activity()
      ..created = DateTime.now()
      ..type = type
      ..distance = distance
      ..date = date
      ..comment = comment;

    final box = Boxes.getActivities();
    box.add(activity);
  }
}
