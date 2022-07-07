// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyuproject/constants/routes.dart';
import 'package:kyuproject/services/auth/auth_exceptions.dart';
import 'package:kyuproject/services/auth/bloc/auth_bloc.dart';
import 'package:kyuproject/services/auth/bloc/auth_event.dart';
import 'package:kyuproject/services/auth/bloc/auth_state.dart';
import 'package:kyuproject/utilities/dialogs/error_dialog.dart';
import 'package:kyuproject/utilities/dialogs/loading_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(
                context, 'Cannot find a user with entered credentials');
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(context, 'Wrong credentials');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Authentication error');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Center(
              child: const Text('Login', style: TextStyle(fontSize: 28))),
          leading: Icon(Icons.login),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/icon/icon.png"),
                          fit: BoxFit.fill)),
                ),
              ),
              const Text(
                'Please log in to your account in order to interact with and add student details!',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Enter your email here',
                ),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: 'Enter your password here',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
                    context.read<AuthBloc>().add(
                          AuthEventLogIn(
                            email,
                            password,
                          ),
                        );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          const AuthEventForgotPassword(),
                        );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'I forgot my password',
                      style: TextStyle(fontSize: 16),
                    ),
                  )),
              TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          const AuthEventShouldRegister(),
                        );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'Not registered yet? Register here!',
                      style: TextStyle(fontSize: 16),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
