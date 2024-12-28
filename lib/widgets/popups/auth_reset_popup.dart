import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remember/helpers/functions.dart';
import 'package:remember/helpers/strings.dart';
import 'package:remember/helpers/validators.dart';
import 'package:remember/widgets/textfields/base_textfield.dart';
import 'package:remember/widgets/buttons/exit_button.dart';

import 'package:remember/widgets/buttons/main_button.dart';

class AuthResetPopup extends StatefulWidget {
  const AuthResetPopup({super.key});

  @override
  State<AuthResetPopup> createState() => _AuthResetPopupState();
}

class _AuthResetPopupState extends State<AuthResetPopup> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final email = _emailController.text.toLowerCase();
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      } on FirebaseAuthException catch (e) {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });
        await handleFirebaseError(e.code, context);
        return;
      }
      if (!mounted) return;
      showToast(checkInbox, context);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                children: [
                  Spacer(),
                  ExitButton(),
                ],
              ),
              Text(
                passwordResetting,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                emailInfo,
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BaseTextfield(
                    validator: emailValidator,
                    hint: "E-mail",
                    controller: _emailController,
                    isEmail: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : MainButton(
                          onPressed: _resetPassword,
                          text: sendMail,
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
