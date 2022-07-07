// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kyuproject/constants/routes.dart';
import 'package:kyuproject/enums/menu_action.dart';
import 'package:kyuproject/services/auth/auth_service.dart';
import 'package:kyuproject/services/auth/bloc/auth_bloc.dart';
import 'package:kyuproject/services/auth/bloc/auth_event.dart';
import 'package:kyuproject/services/cloud/cloud_note.dart';
import 'package:kyuproject/services/cloud/firebase_cloud_storage.dart';
import 'package:kyuproject/utilities/dialogs/logout_dialog.dart';
import 'package:kyuproject/views/notes_list_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;

class StudentsView extends StatefulWidget {
  const StudentsView({Key? key}) : super(key: key);

  @override
  _StudentsViewState createState() => _StudentsViewState();
}

class _StudentsViewState extends State<StudentsView> {
  late final FirebaseCloudStorage _notesService;
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Student's Details"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
                },
                icon: const Icon(Icons.add)),
            PopupMenuButton<MenuAction>(
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.logout:
                    final shouldLogout = await showLogOutDialog(context);
                    if (shouldLogout) {
                      context.read<AuthBloc>().add(
                            const AuthEventLogOut(),
                          );
                    }
                }
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem<MenuAction>(
                    value: MenuAction.logout,
                    child: Text('Log out'),
                  ),
                ];
              },
            )
          ],
        ),
        body: StreamBuilder(
          stream: _notesService.allNotes(ownerUserId: userId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final allNotes = snapshot.data as Iterable<CloudNote>;
                  return NotesListView(
                    notes: allNotes,
                    onDeleteNote: (note) async {
                      await _notesService.deleteNote(
                          documentId: note.documentId);
                    },
                    onTap: (note) {
                      Navigator.of(context).pushNamed(
                        createOrUpdateNoteRoute,
                        arguments: note,
                      );
                    },
                  );
                } else {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const CircularProgressIndicator(),
                  ));
                }
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
