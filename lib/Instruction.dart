import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'Production.dart';
import 'Perception.dart';
import 'Main.dart';
import 'Lessons.dart';

class InstructionTask extends StatefulWidget {
  InstructionTask({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _InstructionTaskState createState() => _InstructionTaskState();
}

class _InstructionTaskState extends State<InstructionTask> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  String answer = "";
  final _formKey = GlobalKey<FormState>();
  bool _firstPress = true;
  String _question =
      "There are many types of fruits. Here are some examples with the English word and pronunciation.";

  //Method to play the audio sample.
  void play(String audio) {
    print("Playing Audio");
    //audioPlayer.play("/test.mp3", isLocal: true);
    audioCache.play(audio);
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
      body: Builder(
        builder: (context) => Center(
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 50),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              width: 1.0, color: Color(0xFFFFDFDFDF)),
                          left: BorderSide(
                              width: 1.0, color: Color(0xFFFFDFDFDF)),
                          right: BorderSide(
                              width: 1.0, color: Color(0xFFFF7F7F7F)),
                          bottom: BorderSide(
                              width: 1.0, color: Color(0xFFFF7F7F7F)),
                        ),
                        color: Color.fromARGB(50, 23, 34, 254),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        _question,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                  SizedBox(width: 50),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Apple", style: Theme.of(context).textTheme.headline5),
                  RaisedButton(
                    onPressed: () => play('apple.m4a'),
                    child: Icon(Icons.play_arrow),
                  ),
                  Image.asset("assets/images/apple.png", height: 75, width: 75),
                ],
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Banana", style: Theme.of(context).textTheme.headline5),
                  RaisedButton(
                    onPressed: () => play('banana.wav'),
                    child: Icon(Icons.play_arrow),
                  ),
                  Image.asset("assets/images/banana.jpg",
                      height: 75, width: 75),
                ],
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Kiwi", style: Theme.of(context).textTheme.headline5),
                  RaisedButton(
                    onPressed: () => play('kiwi.wav'),
                    child: Icon(Icons.play_arrow),
                  ),
                  Image.asset("assets/images/kiwi.jpg", height: 75, width: 75),
                ],
              ),
              SizedBox(height: 65),

              //Navigates to the next page.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new MultipleChoice(
                                title: "Task 2: Multiple Choice Perception")),
                      );
                    },
                    child: Text('Next Exercise'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
