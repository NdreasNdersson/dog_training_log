import 'package:dog_training_log/models/activity.dart';
import 'package:flutter/material.dart';

class ActivityCard extends StatefulWidget {
  final Activity activity;

  const ActivityCard({required this.activity, Key? key}) : super(key: key);

  @override
  State<ActivityCard> createState() => _ActivityCard();
}

class _ActivityCard extends State<ActivityCard> {
  void _onClick() {
    final TextEditingController typeC = TextEditingController();
    final TextEditingController distanceC = TextEditingController();
    final TextEditingController commentC = TextEditingController();

    typeC.text = widget.activity.type;
    distanceC.text = "${widget.activity.distance}";
    commentC.text = widget.activity.comment;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: SizedBox(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextField(
                    controller: typeC,
                  ),
                  TextField(
                    controller: distanceC,
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: commentC,
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
                            editActivity(widget.activity, typeC.text,
                                double.parse(distanceC.text), commentC.text);
                            Navigator.pop(context);
                          },
                          child: const Text("Save"),
                        )
                      ]),
                ],
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

  void editActivity(
      Activity activity, String type, double distance, String comment) {
    activity.type = type;
    activity.distance = distance;
    activity.comment = comment;

    activity.save();
  }
}
