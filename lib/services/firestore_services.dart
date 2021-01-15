import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasks_demo/models/Course.dart';

class FirestoreService {
  //Grab the link to our service
  FirebaseFirestore _db = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  //Upsert (Update and Create, C U)

  //Retrieve (R)
  Stream<List<Course>> getCourses() {
    return _db
        .collection('Users')
        .doc(firebaseUser.uid)
        .collection('Courses')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Course.fromJson(doc.data())).toList());
  }

  //Delete(D)
}
