import 'package:dog_training_log/models/activity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

class ActivityCard extends StatefulWidget {
  final Activity activity;

  const ActivityCard({required this.activity, Key? key}) : super(key: key);

  @override
  State<ActivityCard> createState() => _ActivityCard();
}

class _ActivityCard extends State<ActivityCard> {
  late DateTime _dateTime;

  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  void _onClick() {
    _dateTime = widget.activity.date;

    _typeController.text = widget.activity.type;
    _dateController.text = DateFormat.yMd().format(_dateTime);
    _timeController.text =
        formatDate(_dateTime, [hh, ':', nn, " ", am]).toString();
    _distanceController.text = "${widget.activity.distance}";
    _commentController.text = widget.activity.comment;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _typeController,
                      decoration: const InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          labelText: 'Type',
                          contentPadding: EdgeInsets.all(5)),
                    ),
                    TextField(
                      controller: _distanceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
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
                                  disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none),
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
                                  disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none),
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
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          labelText: 'Comment',
                          contentPadding: EdgeInsets.all(5)),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              widget.activity.delete();
                              Navigator.pop(context);
                            },
                            child: const Text("Delete"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              editActivity(
                                  widget.activity,
                                  _typeController.text,
                                  _dateTime,
                                  double.parse(_distanceController.text),
                                  _commentController.text);
                              Navigator.pop(context);
                            },
                            child: const Text("Save"),
                          )
                        ]),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: Stack(
          children: [
            Card(
              child: InkWell(
                splashColor: Colors.black.withAlpha(30),
                onTap: () {
                  _onClick();
                },
                child: SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.activity.type,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                    "${widget.activity.date.year}-${widget.activity.date.month}-${widget.activity.date.day}"),
                                if (widget.activity.distance != 0.0)
                                  Text("${widget.activity.distance} m")
                                else
                                  const Text("")
                              ]),
                          Text(widget.activity.comment),
                        ])),
              ),
            )
          ],
        ));
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
    );
    if (picked != null) {
      setState(() {
        _dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day,
            picked.hour, picked.minute);
        _timeController.text =
            formatDate(_dateTime, [hh, ':', nn, " ", am]).toString();
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
}
