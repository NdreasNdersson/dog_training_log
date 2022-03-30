import 'package:dog_training_log/boxes.dart';
import 'package:dog_training_log/models/dog.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

class DogEntry extends StatefulWidget {
  final Dog? dog;

  const DogEntry({this.dog, Key? key}) : super(key: key);

  @override
  State<DogEntry> createState() => _DogEntryState();
}

class _DogEntryState extends State<DogEntry> {
  late DateTime _dateTime;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  var deleteCloseText = "Delete";

  @override
  void initState() {
    if (widget.dog != null) {
      _dateTime = widget.dog!.birthday;
      _nameController.text = widget.dog!.name;
      _breedController.text = widget.dog!.breed;
    } else {
      _dateTime = DateTime.now();
      deleteCloseText = "Close";
    }
    _dateController.text = DateFormat.yMd().format(_dateTime);
    _timeController.text = formatDate(_dateTime, [HH, ':', nn]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 400,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        disabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        labelText: 'Name',
                        contentPadding: EdgeInsets.all(5)),
                    minLines: 1,
                  ),
                  TextField(
                    controller: _breedController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        disabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        labelText: 'Breed',
                        contentPadding: EdgeInsets.all(5)),
                  ),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 30),
                      alignment: Alignment.center,
                      width: 150,
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: TextFormField(
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                        enabled: false,
                        keyboardType: TextInputType.text,
                        controller: _dateController,
                        decoration: const InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            labelText: 'Birthday',
                            contentPadding: EdgeInsets.all(5)),
                      ),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (widget.dog != null) {
                              widget.dog!.delete();
                            }
                            Navigator.pop(context);
                          },
                          child: Text(deleteCloseText),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (widget.dog != null) {
                              editDog(widget.dog!, _nameController.text,
                                  _breedController.text, _dateTime);
                            } else {
                              addDog(_nameController.text,
                                  _breedController.text, _dateTime);
                            }
                            Navigator.pop(context);
                          },
                          child: const Text("Save"),
                        )
                      ]),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null && picked != _dateTime) {
      setState(() {
        _dateTime = picked;
        _dateController.text = DateFormat.yMd().format(_dateTime);
      });
    }
  }

  void editDog(Dog dog, String name, String breed, DateTime birthday) {
    dog.name = name;
    dog.breed = breed;
    dog.birthday = birthday;

    dog.save();
  }

  void addDog(String name, String breed, DateTime birthday) {
    final dog = Dog()
      ..name = name
      ..breed = breed
      ..birthday = birthday
      ..image = 'assets/imgs/dog.jpg';

    final box = Boxes.getDogs();
    box.add(dog);
  }
}
