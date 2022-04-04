import 'package:dog_training_log/boxes.dart';
import 'package:dog_training_log/widgets/activitycard.dart';
import 'package:dog_training_log/widgets/activitydialog.dart';
import 'package:dog_training_log/widgets/dogdialog.dart';
import 'package:dog_training_log/widgets/headerbar.dart';
import 'package:dog_training_log/widgets/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:dog_training_log/models/activity.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ActivityListPage extends StatefulWidget {
  const ActivityListPage({Key? key}) : super(key: key);

  @override
  State<ActivityListPage> createState() => _ActivityListPage();
}

class _ActivityListPage extends State<ActivityListPage> {
  @override
  void dispose() {
    Hive.box('activities').close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      drawer: const Drawer(),
      appBar: const HeaderBar('Activity List Page'),
      body: ValueListenableBuilder<Box<Activity>>(
        valueListenable: Boxes.getActivities().listenable(),
        builder: (context, box, _) {
          final activities = box.values.toList().cast<Activity>();
          return buildContent(activities);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (Boxes.getDogs().values.toList().isEmpty) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const DogEntry();
                });
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const ActivityEntry();
                });
          }
        },
        tooltip: 'Add entry',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomBar());

  Widget buildContent(List<Activity> activities) {
    return Stack(
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
              child: ListView.builder(
                  itemCount: activities.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ActivityCard(activity: activities[index]);
                  })),
        ])
      ],
    );
  }
}
