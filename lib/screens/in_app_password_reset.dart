import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember/helpers/functions.dart';
import 'package:remember/helpers/validators.dart';
import 'package:remember/widgets/background.dart';
import 'package:remember/widgets/buttons/main_button.dart';
import 'package:remember/widgets/textfields/base_textfield.dart';

class InAppPasswordReset extends StatefulWidget {
  const InAppPasswordReset({required this.ref, super.key});
  final WidgetRef ref;

  @override
  State<InAppPasswordReset> createState() => _InAppPasswordResetState();
}

class _InAppPasswordResetState extends State<InAppPasswordReset> {
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
          "Hasło zostało zmienione. Zaloguj się ponownie, aby kontynuować.",
          context);
      logOut(widget.ref);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Resetowanie hasła",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Background(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: height > width ? width : width / 2,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BaseTextfield(
                            validator: registerPasswordValidator(
                                _currentPasswordController),
                            hint: "Aktualne hasło",
                            isPassword: true,
                            controller: _currentPasswordController,
                          ),
                          BaseTextfield(
                            validator: registerPasswordValidator(
                                _confirmPasswordController),
                            hint: "Nowe hasło",
                            isPassword: true,
                            controller: _passwordController,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          BaseTextfield(
                            isPassword: true,
                            validator:
                                registerPasswordValidator(_passwordController),
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
