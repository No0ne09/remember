import 'package:flutter/material.dart';
import 'package:remember/widgets/auth_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          children: [
            AuthForm(),
          ],
        )),
      ),
    );
  }
}
