import 'package:flutter/material.dart';
import 'Production.dart';
import 'Main.dart';
import 'dart:collection';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

import 'package:audioplayers/audioplayers.dart';

class MultipleChoice extends StatefulWidget {
  MultipleChoice({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MultipleChoiceState createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<MultipleChoice> {
  AudioPlayer audioPlayer = AudioPlayer();

  //Method to play the audio sample.
  void play() {
    print("Playing Audio");
    audioPlayer.play(
        "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
        isLocal: false);
  }

  void pause() {
    print("Pausing Audio");
    audioPlayer.pause();
  }

  void stop() {
    print("Stopping Audio");
    audioPlayer.stop();
  }

  //Builds the UI.
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    flex: 4,
                    child: Container(
                        child: Text(
                            "What is the word that is pronounced here? Click play to hear the recording."),
                        color: Colors.green,
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 20.0, right: 20.0))),
                Expanded(
                  flex: 4,
                  child: Image.asset("assets/images/apple.png",
                      height: 100, width: 100),
                ),
              ],
            ),
            SizedBox(height: 100),
            Row(
              children: [
                RaisedButton(
                  onPressed: play,
                  child: Text("Play"),
                ),
                RaisedButton(
                  onPressed: stop,
                  child: Text("Stop"),
                ),
              ],
            ),
            //Choice 1 and 2
            Row(
              children: [
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      print("Choice 1 selected");
                    },
                    child: Text('apple'),
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      print("Choice 2 selected");
                    },
                    child: Text('epple'),
                  ),
                ),
              ],
            ),
            //Choice 3 and 4
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                    onPressed: () {
                      print("Choice 3 selected");
                    },
                    child: Text('appal'),
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      print("Choice 4 selected");
                    },
                    child: Text('aple'),
                  ),
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
                      MaterialPageRoute(
                          builder: (context) =>
                              new MultipleChoice(title: "Fill in Demo")),
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
