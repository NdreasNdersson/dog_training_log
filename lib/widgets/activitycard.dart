import 'package:dog_training_log/models/activity.dart';
import 'package:dog_training_log/widgets/activitydialog.dart';
import 'package:flutter/material.dart';

class ActivityCard extends StatefulWidget {
  final Activity activity;

  const ActivityCard({required this.activity, Key? key}) : super(key: key);

  @override
  State<ActivityCard> createState() => _ActivityCard();
}

class _ActivityCard extends State<ActivityCard> {
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
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ActivityEntry(activity: widget.activity);
                      });
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
}
