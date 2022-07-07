// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyuproject/constants/routes.dart';
import 'package:kyuproject/services/auth/auth_exceptions.dart';
import 'package:kyuproject/services/auth/auth_service.dart';
import 'package:kyuproject/services/auth/bloc/auth_bloc.dart';
import 'package:kyuproject/services/auth/bloc/auth_event.dart';
import 'package:kyuproject/services/auth/bloc/auth_state.dart';
import 'package:kyuproject/utilities/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        if (state is AuthStateRegistering) {
          if (state.exception is WeakPasswordAuthException) {
            await showErrorDialog(context, 'Weak password');
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(context, 'Email is already in use');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Failed to register');
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, 'Invalid email');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                      'Enter your email and password to see your student details'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _email,
                    enableSuggestions: false,
                    autocorrect: false,
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email here',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: 'Enter your password here',
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () async {
                          final email = _email.text;
                          final password = _password.text;
                          context.read<AuthBloc>().add(
                                AuthEventRegister(
                                  email,
                                  password,
                                ),
                              );
                        },
                        child: const Text('Register'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                    onPressed: () {
                        context.read<AuthBloc>().add(
                              const AuthEventLogOut(),
                            );
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text('Already registered? Login here!'),
                    ),
                  ),
                      )
                    ],
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
