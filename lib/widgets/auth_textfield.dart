import 'package:flutter/material.dart';
import 'package:remember/helpers/validators.dart';

class AuthTextfield extends StatefulWidget {
  const AuthTextfield({
    this.isEmail = false,
    this.isPassword = false,
    super.key,
  });

  final bool isEmail;
  final bool isPassword;

  @override
  State<AuthTextfield> createState() => _AuthTextfieldState();
}

class _AuthTextfieldState extends State<AuthTextfield> {
  @override
  Widget build(BuildContext context) {
    final validator = widget.isEmail
        ? emailValidator
        : widget.isPassword
            ? registerPasswordValidator
            : usernameValidator;
    return TextFormField(
      validator: validator,
    );
  }
}
