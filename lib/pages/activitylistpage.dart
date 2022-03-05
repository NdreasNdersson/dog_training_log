import 'package:dog_training_log/boxes.dart';
import 'package:dog_training_log/widgets/activitycard.dart';
import 'package:dog_training_log/widgets/headerbar.dart';
import 'package:dog_training_log/widgets/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:dog_training_log/models/activity.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ActivityListPage extends StatefulWidget {
  const ActivityListPage({Key? key}) : super(key: key);

  @override
  State<ActivityListPage> createState() => _ActivityListPage();
}

class _ActivityListPage extends State<ActivityListPage> {

  final TextEditingController _type_c = TextEditingController();
  final TextEditingController _distance_c = TextEditingController();
  // final TextEditingController _date_c = TextEditingController();
  final TextEditingController _comment_c = TextEditingController();

  Dialog _addEntry() {
    return Dialog(
      child: SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(hintText: "Type:"),
              controller: _type_c,
            ),
            TextField(
              decoration: const InputDecoration(hintText: "Distance:"),
              controller: _distance_c,
              keyboardType: TextInputType.number,
            ),
            // TextFormField(
            //   style: const TextStyle(fontSize: 40),
            //   textAlign: TextAlign.center,
            //   enabled: false,
            //   keyboardType: TextInputType.text,
            //   controller: _date_c,
            //   decoration: const InputDecoration(
            //     disabledBorder:
            //     UnderlineInputBorder(borderSide: BorderSide.none),
            //     contentPadding: EdgeInsets.only(top: 0.0)),
            // ),
            TextField(
              decoration: const InputDecoration(hintText: "Comment:"),
              controller: _comment_c,
            ),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  addActivity(_type_c.text, double.parse(_distance_c.text), DateTime.now(), _comment_c.text);
                });
                Navigator.pop(context);
              }, child: const Text("Add"),
            )
          ],
        ),
      ),
    );
  }

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
        onPressed: (){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return _addEntry();
            }
          );
        },
        tooltip: 'Add entry',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar:const BottomBar()
    );

  Widget buildContent(List<Activity> activities) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: activities.length,
                itemBuilder: (BuildContext context, int index) {
                  return ActivityCard(activity: activities[index]);
                }
              )
            ),
          ]
        )
      ],
    );
  }

  void addActivity(String type, double distance, DateTime date, String comment ) {
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