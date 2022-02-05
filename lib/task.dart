// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'isDone.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

late String _userTodo;
bool isDone = false;
bool checkedStatus = false;
Box<dynamic> taskBox = Hive.box('task');
Box<dynamic> chekBox = Hive.box('check');
List<dynamic> todoList = taskBox.get('taskBox', defaultValue: []);
List<dynamic> isDoneTask = chekBox.get('isDoneTask', defaultValue: [0]);
Map<dynamic, dynamic> map = chekBox.get('map', defaultValue: {});
int push = chekBox.get('push', defaultValue: 0);

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (push == 0) ? Colors.white : Color(0xff1E1F2),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 64, top: 64),
                  child: Text(
                    "Tasks",
                    style: TextStyle(
                      color: (push == 0) ? Colors.black : Colors.white,
                      fontFamily: "InterBold",
                      fontSize: 56,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.only(top: 64),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (push == 1) {
                            push = 0;
                            chekBox.put('push', push);
                          } else if (push == 0) {
                            push = 1;
                            chekBox.put('push', push);
                          }
                        });
                      },
                      icon: (push == 0)
                          ? Icon(
                              Icons.wb_sunny_rounded,
                              color: Colors.black,
                              size: 30,
                            )
                          : Icon(
                              Icons.wb_sunny_outlined,
                              color: Colors.white,
                              size: 30,
                            )),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.only(top: 64, right: 64),
                  child: ButtonTheme(
                    height: 56,
                    minWidth: 56,
                    child: RaisedButton(
                      child: Icon(
                        Icons.add_sharp,
                        size: 28,
                        color:
                            (push == 0) ? Color(0xff575767) : Color(0xff24242D),
                      ),
                      color:
                          (push == 0) ? Color(0xffF2F3FF) : Color(0xff575767),
                      elevation: 0.8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: (push == 0)
                                    ? Colors.white
                                    : Color(0xff24242D),
                                title: Text(
                                  'Add a new todo item:',
                                  style: TextStyle(
                                    color: (push == 0)
                                        ? Colors.black
                                        : Colors.white,
                                    fontFamily: 'InterMedium',
                                  ),
                                ),
                                content: TextField(
                                  decoration: InputDecoration(),
                                  onChanged: (String value) {
                                    _userTodo = value;
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    child: Text(
                                      'Add',
                                      style: TextStyle(
                                        color: (push == 0)
                                            ? Colors.black
                                            : Colors.white,
                                        fontFamily: 'InterMedium',
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        todoList.add(_userTodo);
                                        taskBox.put('taskBox', todoList);
                                        Navigator.of(context).pop();
                                      });
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 32, right: 64, left: 64),
              child: Image.asset('images/line.png'),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  top: 32,
                  left: 64,
                  right: 64,
                ),
                child: ListView.builder(
                  itemCount: todoList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Row(
                        children: [
                          TodoIsDone(),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              todoList[index],
                              style: TextStyle(
                                fontFamily: 'InterMedium',
                                fontSize: 18,
                                color: Color(0xff575767),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
