import 'package:flutter/material.dart';
import 'package:remember/widgets/auth_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Re(me)mber"),
            SizedBox(
              height: kToolbarHeight,
              child: Image.asset("assets/logo.png"),
            )
          ],
        ),
      ),
      body: const Center(
        child: AuthForm(),
      ),
    );
  }
}
