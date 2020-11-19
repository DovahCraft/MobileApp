import 'package:flutter/material.dart';
import 'package:tasks_demo/Instruction.dart';
import 'main.dart';
import 'Perception.dart';
import 'Production.dart';
import 'dart:collection';

class LessonPage extends StatefulWidget {
  LessonPage({Key key, this.isOpen}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final bool isOpen;

  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lesson Selection Page'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Please select your desired lesson.",
                style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.event_note),
              title: Text('Lesson 1: Fruits'),
              subtitle: Text(
                  'Mix of perception and production tasks with a fruit theme!'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(width: 3),
                //Only enter the lesson if we have not completed it yet.
                //TODO make this change carry over after we return home!
                TextButton(
                    child: widget.isOpen
                        ? Text('START')
                        : Text(
                            'COMPLETED',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                    onPressed: widget.isOpen
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InstructionTask(
                                      title: "Task 1: Instruction Task")),
                            );
                          }
                        : null),
                const SizedBox(width: 8),
              ],
            ),
            RaisedButton(
                child: Text("Home"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AuthenticationWrapper()),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
