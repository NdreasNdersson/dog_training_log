import 'dart:ui';

import 'package:dog_training_log/widgets/activitycard.dart';
import 'package:dog_training_log/widgets/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:dog_training_log/helpers/utils.dart';
import 'package:dog_training_log/models/activity.dart';

class ActivityListPage extends StatelessWidget {

  List<Activity> activities = Utils.getMockedActivities();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: const Text('Activity List Page'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: const Icon(Icons.account_circle),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: activities.length,
              itemBuilder: (BuildContext ctx, int index) {
                return ActivityCard(activity: activities[index]);
              }
            )
          ),
          const BottomBar(),
        ],
      )
    );
  }
}