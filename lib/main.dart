import 'package:dog_training_log/pages/activitylistpage.dart';
import 'package:dog_training_log/widgets/bottombar.dart';
import 'package:dog_training_log/widgets/headerbar.dart';
import 'package:dog_training_log/helpers/utils.dart';
import 'package:dog_training_log/models/activity.dart';
import 'package:flutter/material.dart';

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
      home: const ActivityListPage()//const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  final String title = 'Home';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _text = "No activity";
  // var activityList = <Activity>[];
  List<Activity> activityList = Utils.getMockedActivities();

  _MyHomePageState() {
    if (activityList.isNotEmpty) {
      _text = activityList.last.toText();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBar('Home'),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Last activity:',
              ),
              Text(
                _text,
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          )
        ]
      ),
      bottomNavigationBar:const BottomBar()
    );
  }
}
