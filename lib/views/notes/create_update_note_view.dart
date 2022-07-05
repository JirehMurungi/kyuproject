// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kyuproject/services/auth/auth_service.dart';
import 'package:kyuproject/utilities/dialogs/cannot_share_empty_note_dialog.dart';
import 'package:kyuproject/utilities/generics/get_arguments.dart';
import 'package:kyuproject/services/cloud/cloud_note.dart';
import 'package:kyuproject/services/cloud/cloud_storage_exceptions.dart';
import 'package:kyuproject/services/cloud/firebase_cloud_storage.dart';
import 'package:share_plus/share_plus.dart';

class CreateUpdateNoteView extends StatefulWidget {
  const CreateUpdateNoteView({Key? key}) : super(key: key);

  @override
  State<CreateUpdateNoteView> createState() => _CreateUpdateNoteViewState();
}

class _CreateUpdateNoteViewState extends State<CreateUpdateNoteView> {
  CloudNote? _note;
  late final FirebaseCloudStorage _notesService;
  late final TextEditingController _textController;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    _textController = TextEditingController();
    super.initState();
  }

  void _textControllerListener() async {
    final note = _note;
    if (note == null) {
      return;
    }
    final text = _textController.text;
    await _notesService.updateNote(
      documentId: note.documentId,
      text: text,
    );
  }

  void _setupTextControllerListener() {
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
  }

  Future<CloudNote> createOrGetExistingNote(BuildContext context) async {
    final widgetNote = context.getArgument<CloudNote>();

    if (widgetNote != null) {
      _note = widgetNote;
      _textController.text = widgetNote.text;
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
    if (_textController.text.isEmpty && note != null) {
      _notesService.deleteNote(documentId: note.documentId);
    }
  }

  void _saveNoteIfTextNotEmpty() async {
    final note = _note;
    final text = _textController.text;
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
    _textController.dispose();
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
                final text = _textController.text;
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
                              child: Text(
                                "Name",
                              ),
                            ),
                            SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _textController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Name is required";
                                  }
                  
                                  return null;
                                },
                                decoration: InputDecoration(
                                    label: Text("Student Name"),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8))),
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
                                controller: _textController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                return "Reg number required";
                                  }
                  
                                  return null;
                                },
                                decoration: InputDecoration(
                                label: Text("REG NO"),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8))),
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
                                controller: _textController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                return "Student no required";
                                  }
                  
                                  return null;
                                },
                                decoration: InputDecoration(
                                label: Text("Student No"),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8))),
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
                                controller: _textController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Course name required";
                                  }
                  
                                  return null;
                                },
                                decoration: InputDecoration(
                                    label: Text("course Name"),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8))),
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
                                controller: _textController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "study year required";
                                  }
                  
                                  return null;
                                },
                                decoration: InputDecoration(
                                    label: Text("Student year"),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8))),
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
                                controller: _textController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "student residential status required";
                                  }
                  
                                  return null;
                                },
                                decoration: InputDecoration(
                                    label: Text("Student residentail status"),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8))),
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
                                controller: _textController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Student contact";
                                  }
                  
                                  return null;
                                },
                                decoration: InputDecoration(
                                    label: Text("Student contact"),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8))),
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
