// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kyuproject/constants/routes.dart';
import 'package:kyuproject/enums/menu_action.dart';
import 'package:kyuproject/services/auth/auth_service.dart';
import 'package:kyuproject/services/auth/bloc/auth_bloc.dart';
import 'package:kyuproject/services/auth/bloc/auth_event.dart';
import 'package:kyuproject/services/cloud/student_cloud.dart';
import 'package:kyuproject/utilities/dialogs/logout_dialog.dart';
import 'package:kyuproject/views/notes_list_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;

import '../../models/student.dart';

class StudentsView extends StatefulWidget {
  const StudentsView({Key? key}) : super(key: key);

  @override
  State<StudentsView> createState() => _StudentsViewState();
}

class _StudentsViewState extends State<StudentsView> {
  // late final FirebaseCloudStorage _notesService;
  late final StudentCloud _studentService;
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _studentService = StudentCloud();
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
                      // ignore: use_build_context_synchronously
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
          // stream: _notesService.allNotes(ownerUserId: userId),
          stream: _studentService.allStudents(ownerUserId: userId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final allNotes = snapshot.data as Iterable<Student>;
                  return NotesListView(
                    notes: allNotes,
                    onDeleteNote: (student) async {
                      await _studentService.deleteStudent(
                          userId: student.userId!);
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
