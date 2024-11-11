import 'package:flutter/material.dart';
import 'package:remember/widgets/auth_form.dart';
import 'package:remember/widgets/background.dart';
import 'package:remember/widgets/title_widget.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const TitleWidget(),
      ),
      body: const Background(
        child: Center(
          child: AuthForm(),
        ),
      ),
    );
  }
}
