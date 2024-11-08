import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember/helpers/functions.dart';
import 'package:remember/helpers/validators.dart';
import 'package:remember/widgets/buttons/exit_button.dart';
import 'package:remember/widgets/buttons/main_button.dart';
import 'package:remember/widgets/textfields/base_textfield.dart';

class InAppResetPopup extends StatefulWidget {
  const InAppResetPopup({required this.ref, super.key});
  final WidgetRef ref;

  @override
  State<InAppResetPopup> createState() => _InAppResetPopupState();
}

class _InAppResetPopupState extends State<InAppResetPopup> {
  final _currentPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _authInstance = FirebaseAuth.instance;
  bool _isResetting = false;
  @override
  void dispose() {
    _currentPasswordController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isResetting = true;
      });
      final oldPassword = _currentPasswordController.text;
      final user = _authInstance.currentUser!;
      try {
        await _authInstance.currentUser!.reauthenticateWithCredential(
            EmailAuthProvider.credential(
                email: user.email!, password: oldPassword));
      } on FirebaseAuthException catch (e) {
        if (!mounted) return;
        handleFireBaseError(e.code, context);
        setState(() {
          _isResetting = false;
        });
        return;
      }
      final newPassword = _passwordController.text;
      try {
        await _authInstance.currentUser!.updatePassword(newPassword);
      } on FirebaseException catch (e) {
        if (!mounted) return;
        handleFireBaseError(e.code, context);
        setState(() {
          _isResetting = false;
        });
        return;
      }
      if (!mounted) return;
      Navigator.pop(context);
      Navigator.pop(context);
      showToast(
          "Hasło zostało zmienione. Zaloguj się poniownie, aby kontynuować.");
      logOut(widget.ref);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      "Resetowanie hasła",
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const Spacer(),
                    const ExitButton(),
                  ],
                ),
                BaseTextfield(
                  validator:
                      registerPasswordValidator(_currentPasswordController),
                  hint: "Aktualne hasło",
                  isPassword: true,
                  controller: _currentPasswordController,
                ),
                BaseTextfield(
                  validator:
                      registerPasswordValidator(_confirmPasswordController),
                  hint: "Nowe hasło",
                  isPassword: true,
                  controller: _passwordController,
                ),
                const SizedBox(
                  height: 8,
                ),
                BaseTextfield(
                  isPassword: true,
                  validator: registerPasswordValidator(_passwordController),
                  hint: "Powtórz nowe hasło",
                  controller: _confirmPasswordController,
                ),
                const SizedBox(
                  height: 8,
                ),
                _isResetting
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : MainButton(
                        text: "Zresetuj hasło",
                        onPressed: _resetPassword,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
