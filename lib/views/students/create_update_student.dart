// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kyuproject/services/auth/auth_service.dart';
import 'package:kyuproject/services/cloud/student_cloud.dart';
import 'package:kyuproject/utilities/dialogs/cannot_share_empty_note_dialog.dart';
import 'package:kyuproject/utilities/generics/get_arguments.dart';
import 'package:kyuproject/services/cloud/cloud_note.dart';
import 'package:kyuproject/services/cloud/firebase_cloud_storage.dart';
import 'package:share_plus/share_plus.dart';

import '../../models/student.dart';

// cloud StudentCloud
StudentCloud _studentCloud = StudentCloud();

class CreateUpdateStudent extends StatefulWidget {
  const CreateUpdateStudent({Key? key}) : super(key: key);

  @override
  State<CreateUpdateStudent> createState() => _CreateUpdateStudentState();
}

class _CreateUpdateStudentState extends State<CreateUpdateStudent> {
  CloudNote? _note;
  late final FirebaseCloudStorage _notesService;
  late final TextEditingController _nameController;
  late final TextEditingController _regnoController;
  late final TextEditingController _courseController;
  late final TextEditingController _residentialController;
  late final TextEditingController _stdContactController;
  late final TextEditingController _studentNoController;
  late final TextEditingController _yearOfStudyController;
  // // number controllers
  // late int? _stdContactController;
  // late  int? _studentNoController;
  // late int? _yearOfStudyController;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    _nameController = TextEditingController();
    _regnoController = TextEditingController();
    _stdContactController = TextEditingController();
    _yearOfStudyController = TextEditingController();
    _studentNoController = TextEditingController();
    _courseController = TextEditingController();
    _residentialController = TextEditingController();

    super.initState();
  }

  void _textControllerListener() async {
    final note = _note;
    if (note == null) {
      return;
    }
    final text = _nameController.text;
    await _notesService.updateNote(
      documentId: note.documentId,
      text: text,
    );
  }

  void _setupTextControllerListener() {
    _nameController.removeListener(_textControllerListener);
    _nameController.addListener(_textControllerListener);
    // mine

    _regnoController.removeListener(_textControllerListener);
    _regnoController.addListener(_textControllerListener);

    _courseController.removeListener(_textControllerListener);
    _courseController.addListener(_textControllerListener);

    _residentialController.removeListener(_textControllerListener);
    _residentialController.addListener(_textControllerListener);

    _stdContactController.removeListener(_textControllerListener);
    _stdContactController.addListener(_textControllerListener);

    _studentNoController.removeListener(_textControllerListener);
    _studentNoController.addListener(_textControllerListener);

    _yearOfStudyController.removeListener(_textControllerListener);
    _yearOfStudyController.addListener(_textControllerListener);
  }

  Future<CloudNote> createOrGetExistingNote(BuildContext context) async {
    final widgetNote = context.getArgument<CloudNote>();

    if (widgetNote != null) {
      _note = widgetNote;
      _nameController.text = widgetNote.text;
      return widgetNote;
    }

    final existingNote = _note;
    if (existingNote != null) {
      return existingNote;
    }
    final currentUser = AuthService.firebase().currentUser!;
    final userId = currentUser.id;
    final newNote = await _notesService.createNewNote(ownerUserId: userId);
    _note = newNote;
    return newNote;
  }

  void _deleteNoteIfTextIsEmpty() {
    final note = _note;
    if (_nameController.text.isEmpty && note != null) {
      _notesService.deleteNote(documentId: note.documentId);
    }
  }

  void _saveNoteIfTextNotEmpty() async {
    final note = _note;
    final text = _nameController.text;
    if (note != null && text.isNotEmpty) {
      await _notesService.updateNote(
        documentId: note.documentId,
        text: text,
      );
    }
  }

  @override
  void dispose() {
    _deleteNoteIfTextIsEmpty();
    _saveNoteIfTextNotEmpty();
    _nameController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New Student'),
          actions: [
            IconButton(
              onPressed: () async {
                final text = _nameController.text;
                if (_note == null || text.isEmpty) {
                  await showCannotShareEmptyNoteDialog(context);
                } else {
                  Share.share(text);
                }
              },
              icon: const Icon(Icons.share),
            )
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: FutureBuilder(
          future: createOrGetExistingNote(context),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                _setupTextControllerListener();
                return Scaffold(
                  body: SafeArea(
                    child: Form(
                      key: _formKey,
                      child: Scrollbar(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView(
                            shrinkWrap: true,
                            // padding: EdgeInsets.all(8.0),
                            children: [
                              SizedBox(height: 16.0),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Name"),
                              ),
                              SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _nameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Name is required";
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    label: Text("Student Name"),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              // field two

                              SizedBox(height: 16.0),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "REG No",
                                ),
                              ),
                              SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _regnoController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Reg number required";
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      label: Text("REG NO"),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                ),
                              ),

                              // std number
                              SizedBox(height: 16.0),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Student no",
                                ),
                              ),
                              SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _studentNoController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Student no required";
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      label: Text("Student No"),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                ),
                              ),
                              // // field 3
                              SizedBox(height: 16.0),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Course",
                                ),
                              ),
                              SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _courseController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Course name required";
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      label: Text("course Name"),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                ),
                              ),
                              // field year of study
                              SizedBox(height: 16.0),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Year of study",
                                ),
                              ),
                              SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _yearOfStudyController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "study year required";
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      label: Text("Student year"),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                ),
                              ),
                              // field residential status
                              SizedBox(height: 16.0),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Residential Status",
                                ),
                              ),
                              SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _residentialController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "student residential status required";
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      label: Text("Student residentail status"),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                ),
                              ),
                              // contact feild
                              SizedBox(height: 16.0),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Student contact",
                                ),
                              ),
                              SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _stdContactController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Student contact";
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      label: Text("Student contact"),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                ),
                              ),

                              // submit button
                              SizedBox(height: 16.0),

                              // submit button
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  onPressed: () {
                                    // validate form
                                    if (_formKey.currentState!.validate()) {
                                      // if valid, save data to cloud
                                      _studentCloud.addNewStudent(
                                        student: Student.sampleStudent,
                                      );
                                      // if form is valid
                                      // submit to database
                                      // _submit();
                                    }
                                  },
                                  child: Text("Submit"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );

              // TextField(
              //   controller: _textController,
              //   keyboardType: TextInputType.multiline,
              //   maxLines: null,
              //   decoration: const InputDecoration(
              //     hintText: 'start typing your student details here...',
              //   ),
              // );
              default:
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const CircularProgressIndicator(),
                ));
            }
          },
        ));
  }
}
