import 'package:flutter/material.dart';
import 'package:task/task.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox<dynamic>('task');
  var checkBox = await Hive.openBox<dynamic>('check');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TaskPage(),
  ));
}
