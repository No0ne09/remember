import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remember/helpers/functions.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final email = _emailController.text.toLowerCase();
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoading = false;
        });
        if (!mounted) return;
        handleFireBaseError(e.code, context);
        return;
      }
      if (!mounted) return;
      showToast("Sprawdź swoją skrzynkę", context);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      content: Form(
        key: _formKey,
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
              "Resetowanie hasła",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: scheme.onPrimaryFixed,
                  ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Na podany adres e-mail otrzymasz wiadomość, która pozwoli Ci na zmianę hasła.",
              style: TextStyle(color: scheme.onPrimaryFixed),
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
                ),
                const SizedBox(
                  height: 10,
                ),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : MainButton(
                        onPressed: _resetPassword,
                        text: "Wyślij wiadomość",
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
