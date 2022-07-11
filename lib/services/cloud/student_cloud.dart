import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/student.dart';
import 'cloud_storage_exceptions.dart';

class StudentCloud {
  // this class uploads and retrieves new users from cloud

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference students =
      FirebaseFirestore.instance.collection('Details');

  Future<void> addNewStudent({required Student student}) async {
    // Call the user's CollectionReference to add a new user
    return await students
        .add(student.toMap())
        // ignore: avoid_print
        .then((value) => print("User Added"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to add user: $error"));
  }

  Stream<Iterable<Student>> allStudents({required String ownerUserId}) =>
      students.snapshots().map((event) => event.docs
          .map((doc) => Student.fromSnapshot(doc))
          .where((student) => student.userId == ownerUserId));

  Future<Iterable<Student>> getStudents({required String ownerUserId}) async {
    try {
      return await students.where("userID", isEqualTo: ownerUserId).get().then(
            (value) => value.docs.map((doc) => Student.fromSnapshot(doc)),
          );
    } catch (e) {
      throw CouldNotGetAllNotesException();
    }
  }

  //
  Future<void> updateStudent({required Student student}) async {
    // Call the user's CollectionReference to update a user
    return await students
        .doc(student.userId)
        .update(student.toMap())
        // ignore: avoid_print
        .then((value) => print("User Updated"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to update user: $error"));
  }

  // delete
  Future<void> deleteStudent({required String userId}) async {
    // Call the user's CollectionReference to delete a user
    return await students
        .doc(userId)
        .delete()
        // ignore: avoid_print
        .then((value) => print("User Deleted"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
