import 'package:dog_training_log/main.dart';
import 'package:dog_training_log/pages/activitylistpage.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ActivityListPage()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
