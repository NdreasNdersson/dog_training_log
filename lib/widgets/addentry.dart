import 'package:flutter/material.dart';
import 'package:dog_training_log/models/activity.dart';

class AddEntry extends StatefulWidget {
  List<Activity> activityList;

  AddEntry({required this.activityList, Key? key}) : super(key: key);

  @override
  State<AddEntry> createState() => _AddEntry();
}

class _AddEntry extends State<AddEntry> {

  final TextEditingController _type_c = TextEditingController();
  final TextEditingController _distance_c = TextEditingController();
  // final TextEditingController _date_c = TextEditingController();
  final TextEditingController _comment_c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Dialog(
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
                widget.activityList.add(Activity(type: _type_c.text, distance: double.parse(_distance_c.text), date: DateTime.now(), comment: _comment_c.text));
                Navigator.pop(context);
              }, child: const Text("Add"),
            )
          ],
        ),
      ),
    );
  }
}