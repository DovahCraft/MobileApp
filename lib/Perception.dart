import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';
import 'Production.dart';
import 'Main.dart';
import 'Lessons.dart';

import 'dart:developer';

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
  static AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache(fixedPlayer: audioPlayer);
  bool pressed = false;
  bool buttonsDisabled = false;
  String _instruction =
      "What is the word that is pronounced here? Click play to hear the recording.";

  //Method to play the audio sample. Not currently using the method for local asset playback.
  void play() {
    print("Playing Audio");
    //audioPlayer.play("/test.mp3", isLocal: true);
    audioCache.play('assets/audio/test.mp3');
  }

  void pause() {
    print("Pausing Audio");
    audioPlayer.pause();
  }

  void stop() {
    print("Stopping Audio");
    audioPlayer.stop();
  }

  void checkanswer(bool isCorrect) {
    print("Checking answers!");
    setState(() {
      buttonsDisabled = true;
    });
  }

  void disablebuttons() {
    setState(() {
      buttonsDisabled = true;
    });
  }

  //Builds the UI.
  @override
  Widget build(
    BuildContext context,
  ) {
    final key = new GlobalKey<ScaffoldState>();
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        key: key,
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
                          child: Text(_instruction),
                          color: Colors.green,
                          padding: const EdgeInsets.only(
                              top: 20.0,
                              bottom: 20.0,
                              left: 20.0,
                              right: 20.0))),
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
                    onPressed: () => audioCache.play('apple.m4a'),
                    child: Icon(Icons.play_arrow),
                  ),
                  RaisedButton(
                    onPressed: () => audioPlayer.pause(),
                    child: Icon(Icons.pause),
                  ),
                  RaisedButton(
                    onPressed: () => audioPlayer.stop(),
                    child: Icon(Icons.stop),
                  ),
                ],
              ),
              SizedBox(height: 50),
              //Choice 1 and 2
              Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      highlightColor: Colors.green,
                      color: Colors.blue,
                      onPressed: () {
                        key.currentState.showSnackBar(new SnackBar(
                          content: new Text("Correct! Good job! :)"),
                        ));
                      },
                      child: Text('apple'),
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: RaisedButton(
                      highlightColor: Colors.red,
                      color: Colors.blue,
                      onPressed: () {
                        key.currentState.showSnackBar(new SnackBar(
                          content: new Text("Incorrect"),
                        ));
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
                      highlightColor: Colors.red,
                      color: Colors.blue,
                      onPressed: () {
                        key.currentState.showSnackBar(new SnackBar(
                          content: new Text("Incorrect"),
                        ));
                      },
                      child: Text('appal'),
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: RaisedButton(
                      highlightColor: Colors.red,
                      color: Colors.blue,
                      onPressed: () {
                        key.currentState.showSnackBar(new SnackBar(
                          content: new Text("Incorrect"),
                        ));
                      },
                      child: Text('aple'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 150),
              //Navigates to the next page.
              Row(
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new FreeText(
                                title: "Task 3: Free Text Perception")),
                      );
                    },
                    child: Text('Next Exercise.'),
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

class FreeText extends StatefulWidget {
  FreeText({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _FreeTextState createState() => _FreeTextState();
}

class _FreeTextState extends State<FreeText> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  String answer = "";
  final _formKey = GlobalKey<FormState>();
  bool _firstPress = true;

  //Method to play the audio sample.
  void play() {
    print("Playing Audio");
    //audioPlayer.play("/test.mp3", isLocal: true);
    audioCache.play('apple.m4a');
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
                children: <Widget>[
                  Expanded(
                      flex: 4,
                      child: Container(
                          child: Text(
                              "What is the word that is pronounced here? Click play to hear the recording."),
                          color: Colors.green,
                          padding: const EdgeInsets.only(
                              top: 20.0,
                              bottom: 20.0,
                              left: 20.0,
                              right: 20.0))),
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
                    onPressed: () => audioCache.play('apple.m4a'),
                    child: Icon(Icons.play_arrow),
                  ),
                  RaisedButton(
                    onPressed: () => audioPlayer.pause(),
                    child: Icon(Icons.pause),
                  ),
                  RaisedButton(
                    onPressed: () => audioPlayer.stop(),
                    child: Icon(Icons.stop),
                  ),
                ],
              ),
              SizedBox(height: 100),

              Row(
                children: [
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: RaisedButton(
                              color: _firstPress ? Colors.blue : Colors.grey,
                              onPressed: () {
                                // Validate returns true if the form is valid, or false
                                // otherwise.
                                //Only do this on the firstPress of the button.
                                if (_firstPress) {
                                  if (_formKey.currentState.validate()) {
                                    // If the form is valid, display a Snackbar.
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text(
                                            'Answer submitted, move to the next exercise!')));
                                  }
                                  //Change the button to disabled
                                  setState(() {
                                    _firstPress = !_firstPress;
                                  });
                                }
                              },
                              child: Text('Submit'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              //Navigates to the next page.
              Row(
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new VideoTask(
                                title: "Task 69: Video Perception")),
                      );
                    },
                    child: Text('Next Exercise.'),
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

class VideoTask extends StatefulWidget {
  VideoTask({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _VideoTaskState createState() => _VideoTaskState();
}

class _VideoTaskState extends State<VideoTask> {
  String answer = "";
  String vidUrl;
  String vidId;
  final _formKey = GlobalKey<FormState>();
  bool _firstPress = true;
  //Controls the youtubeplayer widget
  YoutubePlayerController _controller;
  //Video metadata
  YoutubeMetaData _videoMetaData;
  //Current state of the YoutubePlayer.
  PlayerState _playerState;

  //Volume and listener variables
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    //Hardcoded value for link for now, will pull from database.
    vidUrl = "https://www.youtube.com/watch?v=51r5f5OdIY0";
    //Strip the url for just the video id.
    vidId = YoutubePlayer.convertUrlToId(vidUrl);
    _controller = YoutubePlayerController(
      initialVideoId: vidId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    //_seekToController = TextEditingController();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    //_idController.dispose();
    //_seekToController.dispose();
    super.dispose();
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
                children: <Widget>[
                  Expanded(
                      flex: 4,
                      child: Container(
                          child: Text(
                              "Write a brief summary of this video. What emotions were conveyed?"),
                          color: Colors.green,
                          padding: const EdgeInsets.only(
                              top: 20.0,
                              bottom: 20.0,
                              left: 20.0,
                              right: 20.0))),
                  Expanded(
                    flex: 4,
                    child: Image.asset("assets/images/apple.png",
                        height: 100, width: 100),
                  ),
                ],
              ),
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blueAccent,
                topActions: <Widget>[
                  const SizedBox(width: 8.0),
                  //This expanded widget is the onclicked overlay info for the video.
                  Expanded(
                    child: Text(
                      _controller.metadata.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 25.0,
                    ),
                    onPressed: () {
                      log('Settings Tapped!');
                    },
                  ),
                ],
                onReady: () {
                  _isPlayerReady = true;
                },
              ),
              SizedBox(height: 100),

              Row(
                children: [
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: RaisedButton(
                              color: _firstPress ? Colors.blue : Colors.grey,
                              onPressed: () {
                                // Validate returns true if the form is valid, or false
                                // otherwise.
                                //Only do this on the firstPress of the button.
                                if (_firstPress) {
                                  if (_formKey.currentState.validate()) {
                                    // If the form is valid, display a Snackbar.
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text(
                                            'Answer submitted, move to the next exercise!')));
                                  }
                                  //Change the button to disabled
                                  setState(() {
                                    _firstPress = !_firstPress;
                                  });
                                }
                              },
                              child: Text('Submit'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              //Navigates to the next page.
              Row(
                children: [
                  RaisedButton(
                    onPressed: () {
                      deactivate();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new ConstrainedProduction(
                                title: "Task 4: Constrained Production")),
                      );
                    },
                    child: Text('Next Exercise.'),
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
