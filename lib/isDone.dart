// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';

import 'task.dart';

class TodoIsDone extends StatefulWidget {
  // bool? isDone;
  // TodoIsDone({@required this.isDone});
  @override
  _TodoIsDoneState createState() => _TodoIsDoneState();
}

bool _ToDo = chekBox.get('_ToDo', defaultValue: false);

class _TodoIsDoneState extends State<TodoIsDone> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        fillColor: MaterialStateProperty.all(Colors.grey[850]),
        splashRadius: 0.0,
        value: _ToDo,
        activeColor: Color(0xff575767),
        hoverColor: (push == 0) ? Color(0xff575767) : Colors.white,
        onChanged: (bool? value) {
          setState(() {
            _ToDo = value!;
            chekBox.put('_ToDo', _ToDo);
          });
        });
  }
}
