import 'package:dog_training_log/pages/activitylistpage.dart';
import 'package:flutter/material.dart';
import 'helpers/utils.dart';
import 'models/activity.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog training log',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: ActivityListPage()//const MyHomePage(title: 'Overview'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _text = "No activity";
  var activityList = <Activity>[];
  final TextEditingController _type_c = TextEditingController();
  final TextEditingController _distance_c = TextEditingController();
  final TextEditingController _date_c = TextEditingController();
  final TextEditingController _comment_c = TextEditingController();

  void _addEntry() {
    showDialog(
      context: context,
      builder: (BuildContext context){
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
                      _text = activityList.last.toText();
                    });
                    Navigator.pop(context);
                  }, child: const Text("Add"),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Last activity:',
            ),
            Text(
              _text,
              style: Theme.of(context).textTheme.headline4,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEntry,
        tooltip: 'Add entry',
        child: const Icon(Icons.add),
      ),
    );
  }
}
