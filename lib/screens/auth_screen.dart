import 'package:flutter/material.dart';
import 'package:remember/widgets/auth_form.dart';
import 'package:remember/widgets/background.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Re(me)mber"),
            SizedBox(
              height: kToolbarHeight,
              child: Image.asset("assets/logo.png"),
            )
          ],
        ),
      ),
      body: const Background(
        child: Center(
          child: AuthForm(),
        ),
      ),
    );
  }
}
