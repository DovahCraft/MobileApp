import 'package:flutter/material.dart';
import 'Production.dart';
import 'Main.dart';
import 'dart:collection';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class PerceptionTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multiple Choice Perception Task"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Row(
              children: [
                Text("What is the word that is pronounced here? "),
                Expanded(
                  flex: 4,
                  child: Image.asset("assets/images/apple.png"),
                ),
              ],
            ),
            //Choice 1 and 2
            Row(
              children: [
                RaisedButton(
                  onPressed: () {
                    print("Choice 1 selected");
                  },
                  child: Text('apple'),
                ),
                SizedBox(width: 30),
                RaisedButton(
                  onPressed: () {
                    print("Choice 2 selected");
                  },
                  child: Text('epple'),
                ),
              ],
            ),
            //Choice 3 and 4
            Row(
              children: [
                RaisedButton(
                  onPressed: () {
                    print("Choice 3 selected");
                  },
                  child: Text('appal'),
                ),
                SizedBox(width: 30),
                RaisedButton(
                  onPressed: () {
                    print("Choice 4 selected");
                  },
                  child: Text('aple'),
                ),
              ],
            ),
            SizedBox(height: 300),
            //Navigates to the next page.
            Row(
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UnpopRoute()),
                    );
                  },
                  child: Text('Next Exercise.'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
