import 'package:flutter/material.dart';

class Task {
  //Prompt that appears in the green box
  String prompt;

  //Flag to designate task type
  String taskType;

  //For perception tasks, this designates the audio or video to be played.
  String mediaLink;

  //Image link
  String imageLink;

  //Number of attempts on this task
  int attempts = 0;

  Task({@required this.prompt});
}
