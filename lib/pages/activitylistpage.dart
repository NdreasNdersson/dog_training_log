import 'package:dog_training_log/widgets/activitycard.dart';
import 'package:dog_training_log/widgets/addentry.dart';
import 'package:dog_training_log/widgets/headerbar.dart';
import 'package:dog_training_log/widgets/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:dog_training_log/helpers/utils.dart';
import 'package:dog_training_log/models/activity.dart';

class ActivityListPage extends StatefulWidget {
  const ActivityListPage({Key? key}) : super(key: key);

  @override
  State<ActivityListPage> createState() => _ActivityListPage();
}

class _ActivityListPage extends State<ActivityListPage> {
  List<Activity> activityList = Utils.getMockedActivities();

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
                  activityList.add(Activity(type: _type_c.text, distance: double.parse(_distance_c.text), date: DateTime.now(), comment: _comment_c.text));
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
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: const HeaderBar('Activity List Page'),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: activityList.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return ActivityCard(activity: activityList[index]);
                  }
                )
              ),
            ]
          )
        ],
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
  }
}