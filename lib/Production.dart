import 'package:flutter/material.dart';
import 'main.dart';
import 'main.dart';
import 'dart:collection';
import 'dart:io' as io;
import 'dart:async';

import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';

//Widget defining the constrained speech audio demo.
class ConstrainedProduction extends StatefulWidget {
  ConstrainedProduction({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _ConstrainedProductionState createState() => _ConstrainedProductionState();
}

//Credit for this widget goes to the flutter_audio_recorder team.
class _ConstrainedProductionState extends State<ConstrainedProduction> {
  FlutterAudioRecorder _recorder;
  Recording _recording;
  Timer _t;
  Widget _buttonIcon = Icon(Icons.do_not_disturb_on);
  String _alert;
  String _instruction = '''Please pronounce the word listed below. Only record 
  youself saying the presented word. Click Play to review the recording and move
  on to the next exercise to submit.''';
  String _word = "apple";

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _prepare();
    });
  }

//Used to control the recording button programmatically.
  void _opt() async {
    switch (_recording.status) {
      case RecordingStatus.Initialized:
        {
          await _startRecording();
          break;
        }
      case RecordingStatus.Recording:
        {
          await _stopRecording();
          break;
        }
      case RecordingStatus.Stopped:
        {
          await _prepare();
          break;
        }

      default:
        break;
    }

    // 刷新按钮 (Refresh Button)
    setState(() {
      _buttonIcon = _playerIcon(_recording.status);
    });
  }

  Future _init() async {
    //This grabs the default directory for either IOS or Android
    String customPath = '/flutter_audio_recorder_';
    io.Directory appDocDirectory;

    //We have an iOS device
    if (io.Platform.isIOS) {
      appDocDirectory = await getApplicationDocumentsDirectory();
    }
    //Grab the default directory of the android device.
    else {
      appDocDirectory = await getExternalStorageDirectory();
    }

    // can add extension like ".mp4" ".wav" ".m4a" ".aac"
    customPath = appDocDirectory.path +
        customPath +
        DateTime.now().millisecondsSinceEpoch.toString() +
        ".wav";

    // .wav <---> AudioFormat.WAV
    // .mp4 .m4a .aac <---> AudioFormat.AAC
    // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.

    _recorder = FlutterAudioRecorder(customPath,
        audioFormat: AudioFormat.WAV, sampleRate: 22050);
    await _recorder.initialized;
  }

  Future _prepare() async {
    var hasPermission = await FlutterAudioRecorder.hasPermissions;
    if (hasPermission) {
      await _init();
      var result = await _recorder.current();
      setState(() {
        _recording = result;
        _buttonIcon = _playerIcon(_recording.status);
        _alert = "";
      });
    } else {
      setState(() {
        _alert = "Permission Required.";
      });
    }
  }

  Future _startRecording() async {
    await _recorder.start();
    var current = await _recorder.current();
    setState(() {
      _recording = current;
    });

    //This updates the timer for some reason, not too sure, doesnt increment duration during recording if removed.
    _t = Timer.periodic(Duration(milliseconds: 10), (Timer t) async {
      var current = await _recorder.current();
      setState(() {
        _recording = current;
        _t = t;
      });
    });
  }

  Future _stopRecording() async {
    var result = await _recorder.stop();
    _t.cancel();

    setState(() {
      _recording = result;
    });
  }

  void _play() {
    AudioPlayer player = AudioPlayer();
    player.play(_recording.path, isLocal: true);
  }

//This case statement sets the image of the recording icon based on the current state of the app.
  Widget _playerIcon(RecordingStatus status) {
    switch (status) {
      case RecordingStatus.Initialized:
        {
          //Which is the regular dot recording button
          return Text("Record");
        }
      case RecordingStatus.Recording:
        {
          //Which is the standard stop recording icon
          return Text("Stop Record");
        }
      case RecordingStatus.Stopped:
        {
          //After we stop, show the arrow to replay.
          return Text("Retry?");
        }
      //This is if nothing else works and something really is weird.
      default:
        return Text("Record debug");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Text(_instruction),
                    color: Colors.green,
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Image.asset("assets/images/apple.png",
                      height: 100, width: 100),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  _word,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            //Text(
            //  '${_recording?.path ?? "-"}',
            //  style: Theme.of(context).textTheme.bodyText2,
            //),
            SizedBox(
              height: 20,
            ),
            //Text(
            //  'Duration',
            //  style: Theme.of(context).textTheme.headline6,
            //),
            SizedBox(
              height: 5,
            ),
            //Text(
            //  '${_recording?.duration ?? "-"}',
            //  style: Theme.of(context).textTheme.bodyText2,
            //),
            SizedBox(
              height: 20,
            ),
            //Could be used for future metrics!
            //Text(
            //'Metering Level - Average Power',
            //style: Theme.of(context).textTheme.headline6,
            //),
            SizedBox(
              height: 5,
            ),
            //Text(
            //  '${_recording?.metering?.averagePower ?? "--"}',
            //  style: Theme.of(context).textTheme.bodyText2,
            //),
            SizedBox(
              height: 20,
            ),
            //Text(
            // 'Status',
            //style: Theme.of(context).textTheme.headline6,
            // ),
            SizedBox(
              height: 5,
            ),
            //Useful for debugging later
            // Text(
            //  '${_recording?.status ?? "-"}',
            // style: Theme.of(context).textTheme.bodyText2,
            //),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: RaisedButton(
                    child: Text('Play'),
                    disabledTextColor: Colors.white,
                    disabledColor: Colors.grey.withOpacity(0.5),
                    //If the recording status is stopped, run play, otherwise
                    //Do nothing.
                    onPressed: _recording?.status == RecordingStatus.Stopped
                        ? _play
                        : null,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: RaisedButton(
                    onPressed: _opt,
                    child: _buttonIcon,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 20,
            ),
            // Text(
            //   '${_alert ?? ""}',
            //   style: Theme.of(context)
            //       .textTheme
            //       .headline6
            //       .copyWith(color: Colors.red),
            // ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => new UnconstrainedProduction(
                          title: "Question 4: Unconstrained Production")),
                );
              },
              child: Text('Next Exercise.'),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

//Widget defining the constrained speech audio demo.
class UnconstrainedProduction extends StatefulWidget {
  UnconstrainedProduction({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _UnconstrainedProductionState createState() =>
      _UnconstrainedProductionState();
}

//Credit for this widget goes to the flutter_audio_recorder team.
class _UnconstrainedProductionState extends State<UnconstrainedProduction> {
  FlutterAudioRecorder _recorder;
  Recording _recording;
  Timer _t;
  Widget _buttonIcon = Icon(Icons.do_not_disturb_on);
  String _alert;
  String _instruction =
      '''Please record yourself answering the prompt below. When finished, click stop and review your submission. Move on if you are ready.''';
  String _question =
      "Do you think children prefer to eat fruits or vegetables? How should we encourage children to eat healthy foods?";

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _prepare();
    });
  }

//Used to control the recording button programmatically.
  void _opt() async {
    switch (_recording.status) {
      case RecordingStatus.Initialized:
        {
          await _startRecording();
          break;
        }
      case RecordingStatus.Recording:
        {
          await _stopRecording();
          break;
        }
      case RecordingStatus.Stopped:
        {
          await _prepare();
          break;
        }

      default:
        break;
    }

    // 刷新按钮 (Refresh Button)
    setState(() {
      _buttonIcon = _playerIcon(_recording.status);
    });
  }

  Future _init() async {
    //This grabs the default directory for either IOS or Android
    String customPath = '/flutter_audio_recorder_';
    io.Directory appDocDirectory;

    //We have an iOS device
    if (io.Platform.isIOS) {
      appDocDirectory = await getApplicationDocumentsDirectory();
    }
    //Grab the default directory of the android device.
    else {
      appDocDirectory = await getExternalStorageDirectory();
    }

    // can add extension like ".mp4" ".wav" ".m4a" ".aac"
    customPath = appDocDirectory.path +
        customPath +
        DateTime.now().millisecondsSinceEpoch.toString() +
        ".wav";

    // .wav <---> AudioFormat.WAV
    // .mp4 .m4a .aac <---> AudioFormat.AAC
    // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.

    _recorder = FlutterAudioRecorder(customPath,
        audioFormat: AudioFormat.WAV, sampleRate: 22050);
    await _recorder.initialized;
  }

  Future _prepare() async {
    var hasPermission = await FlutterAudioRecorder.hasPermissions;
    if (hasPermission) {
      await _init();
      var result = await _recorder.current();
      setState(() {
        _recording = result;
        _buttonIcon = _playerIcon(_recording.status);
        _alert = "";
      });
    } else {
      setState(() {
        _alert = "Permission Required.";
      });
    }
  }

  Future _startRecording() async {
    await _recorder.start();
    var current = await _recorder.current();
    setState(() {
      _recording = current;
    });

    //This updates the timer for some reason, not too sure, doesnt increment duration during recording if removed.
    _t = Timer.periodic(Duration(milliseconds: 10), (Timer t) async {
      var current = await _recorder.current();
      setState(() {
        _recording = current;
        _t = t;
      });
    });
  }

  Future _stopRecording() async {
    var result = await _recorder.stop();
    _t.cancel();

    setState(() {
      _recording = result;
    });
  }

  void _play() {
    AudioPlayer player = AudioPlayer();
    player.play(_recording.path, isLocal: true);
  }

//This case statement sets the image of the recording icon based on the current state of the app.
  Widget _playerIcon(RecordingStatus status) {
    switch (status) {
      case RecordingStatus.Initialized:
        {
          //Which is the regular dot recording button
          return Text("Record");
        }
      case RecordingStatus.Recording:
        {
          //Which is the standard stop recording icon
          return Text("Stop Record");
        }
      case RecordingStatus.Stopped:
        {
          //After we stop, show the arrow to replay.
          return Text("Retry?");
        }
      //This is if nothing else works and something really is weird.
      default:
        return Text("Record debug");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Text(_instruction),
                    color: Colors.green,
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Image.asset("assets/images/apple.png",
                      height: 100, width: 100),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 50),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 50),
                    child: Text(
                      _question,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                SizedBox(width: 50),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: RaisedButton(
                    child: Text('Play'),
                    disabledTextColor: Colors.white,
                    disabledColor: Colors.grey.withOpacity(0.5),
                    //If the recording status is stopped, run play, otherwise
                    //Do nothing.
                    onPressed: _recording?.status == RecordingStatus.Stopped
                        ? _play
                        : null,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: RaisedButton(
                    onPressed: _opt,
                    child: _buttonIcon,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                if (_recording?.status == RecordingStatus.Stopped) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => new CoursePage()),
                  );
                }
              },
              child: Text('Next Exercise.'),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
