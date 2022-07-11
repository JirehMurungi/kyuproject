import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/student.dart';

class StudentCloud {
  // this class uploads and retrieves new users from cloud

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('Details');

   Future<void> addNewStudent({required Student student}) async {
    // Call the user's CollectionReference to add a new user
    return await users
        .add(student.toMap())
        // ignore: avoid_print
        .then((value) => print("User Added"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to add user: $error"));
  }

  // 
}
