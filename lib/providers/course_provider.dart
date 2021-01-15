import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:tasks_demo/models/Course.dart';
import 'package:tasks_demo/services/firestore_services.dart';

class CourseProvider with ChangeNotifier {
  //Class private variables to be retrieved via getters
  final firestoreService = FirestoreService();
  String _name;
  String _prefix;
  String _id;

  //Getters
  String get name => _name;
  String get prefix => _prefix;

  Stream<List<Course>> get courses => firestoreService.getCourses();
}
