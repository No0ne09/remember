import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remember/helpers/functions.dart';
import 'package:remember/helpers/strings.dart';
import 'package:remember/helpers/validators.dart';
import 'package:remember/widgets/layout/background.dart';
import 'package:remember/widgets/buttons/main_button.dart';
import 'package:remember/widgets/textfields/base_textfield.dart';

class InAppPasswordReset extends StatefulWidget {
  const InAppPasswordReset({super.key});

  @override
  State<InAppPasswordReset> createState() => _InAppPasswordResetState();
}

class _InAppPasswordResetState extends State<InAppPasswordReset> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _authInstance = FirebaseAuth.instance;
  bool _isResetting = false;

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isResetting = true;
      });
      final oldPassword = _oldPasswordController.text;
      final user = _authInstance.currentUser!;
      try {
        await _authInstance.currentUser!.reauthenticateWithCredential(
            EmailAuthProvider.credential(
                email: user.email!, password: oldPassword));
      } on FirebaseAuthException catch (e) {
        if (!mounted) return;
        await handleFireBaseError(e.code, context);
        setState(() {
          _isResetting = false;
        });
        return;
      }
      final newPassword = _newPasswordController.text;
      try {
        await _authInstance.currentUser!.updatePassword(newPassword);
      } on FirebaseAuthException catch (e) {
        if (!mounted) return;
        await handleFireBaseError(e.code, context);
        setState(() {
          _isResetting = false;
        });
        return;
      }
      if (!mounted) return;
      Navigator.pop(context);
      Navigator.pop(context);
      showToast(passwordChanged, context);
      _authInstance.signOut();
    }
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          passwordReset,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Background(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: height > width ? width : width / 2,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BaseTextfield(
                            validator: registerPasswordValidator(
                                _oldPasswordController),
                            hint: currentPassword,
                            isPassword: true,
                            controller: _oldPasswordController,
                          ),
                          BaseTextfield(
                            validator: registerPasswordValidator(
                                _confirmPasswordController),
                            hint: newPassword,
                            isPassword: true,
                            controller: _newPasswordController,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          BaseTextfield(
                            isPassword: true,
                            validator: registerPasswordValidator(
                                _newPasswordController),
                            hint: confirmNewPassword,
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
                                  text: resetPassword,
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
