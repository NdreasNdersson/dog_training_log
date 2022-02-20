import 'package:dog_training_log/models/activity.dart';
import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;

  const ActivityCard({required this.activity, Key? key}) : super(key: key);

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
                debugPrint("${activity.type} ${activity.date.year}-${activity.date.month}-${activity.date.day} taped");
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
                        Text(activity.type,
                          style: const TextStyle(fontWeight: FontWeight.bold,),
                        ),
                        Text("${activity.date.year}-${activity.date.month}-${activity.date.day}"),
                        if(activity.distance != 0.0)
                          Text("${activity.distance} m")
                        else
                          const Text("")
                      ]
                    ),
                    Text(activity.comment),
                  ]
                )
              ),
            ),
          )
        ],
      )
    );
  }
}