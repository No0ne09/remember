import 'package:flutter/material.dart';
import 'package:remember/helpers/validators.dart';
import 'package:remember/widgets/auth_textfield.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLogin = false;
  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
                children: [
                  AuthTextfield(
                    hint: "Nazwa użytkownika",
                    validator: usernameValidator,
                    controller: _usernameController,
                  ),
                  AuthTextfield(
                    hint: "Adres email",
                    isEmail: true,
                    validator: emailValidator,
                    controller: _emailController,
                  ),
                  AuthTextfield(
                    hint: "Hasło",
                    isPassword: true,
                    validator:
                        registerPasswordValidator(_confirmPasswordController),
                    controller: _passwordController,
                  ),
                  AuthTextfield(
                    hint: "Powtórz Hasło",
                    isPassword: true,
                    validator: registerPasswordValidator(_passwordController),
                    controller: _confirmPasswordController,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _formKey.currentState!.validate();
                      },
                      child: const Text("siup"))
                ],
              ),
            ),
          ),
        ));
  }
}
