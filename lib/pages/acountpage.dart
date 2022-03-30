import 'dart:io';

import 'package:dog_training_log/boxes.dart';
import 'package:dog_training_log/models/dog.dart';
import 'package:dog_training_log/widgets/dogdialog.dart';
import 'package:dog_training_log/widgets/headerbar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBar('Your account'),
      body: ValueListenableBuilder<Box<Dog>>(
        valueListenable: Boxes.getDogs().listenable(),
        builder: (context, box, _) {
          final dogs = box.values.toList().cast<Dog>();
          return buildContent(dogs);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const DogEntry();
              });
        },
        tooltip: 'Add entry',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildContent(List<Dog> dogs) {
    return Stack(
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: dogs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        Image(
                          image: AssetImage(dogs[index].image),
                          height: 25,
                        ),
                        Text(dogs[index].name),
                      ],
                    );
                  })),
        ])
      ],
    );
  }
}
