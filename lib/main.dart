import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyuproject/constants/routes.dart';
import 'package:kyuproject/helpers/loading/loading_screen.dart';
import 'package:kyuproject/services/auth/bloc/auth_bloc.dart';
import 'package:kyuproject/services/auth/bloc/auth_event.dart';
import 'package:kyuproject/services/auth/bloc/auth_state.dart';
import 'package:kyuproject/services/auth/firebase_auth_provider.dart';
import 'package:kyuproject/views/forgot_password_view.dart';
import 'package:kyuproject/views/login_view.dart';
import 'package:kyuproject/views/register_view.dart';
import 'package:kyuproject/views/verify_email_view.dart';

import 'views/students/create_update_student.dart';
import 'views/students/students_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'A Notebook on the go',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        createOrUpdateNoteRoute: (context) => const CreateUpdateStudent(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Please wait a moment',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const StudentsView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
