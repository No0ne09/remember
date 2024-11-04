import 'package:flutter/material.dart';
import 'package:remember/widgets/auth_textfield.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = false;
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.red,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [AuthTextfield()],
              ),
            ),
          ),
        ));
  }
}
