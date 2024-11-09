import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember/helpers/functions.dart';
import 'package:remember/helpers/providers.dart';
import 'package:remember/helpers/strings.dart';
import 'package:remember/helpers/validators.dart';
import 'package:remember/widgets/textfields/base_textfield.dart';
import 'package:remember/widgets/popups/auth_reset_popup.dart';
import 'package:remember/widgets/buttons/main_button.dart';

class AuthForm extends ConsumerStatefulWidget {
  const AuthForm({super.key});

  @override
  ConsumerState<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends ConsumerState<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLogin = true;
  bool _isProcessing = false;
  final _authInstance = FirebaseAuth.instance;
  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _validate() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isProcessing = true;
      });
      final username = _usernameController.text;
      final email = _emailController.text.toLowerCase();
      final password = _passwordController.text;

      _isLogin
          ? _loginUser(email, password)
          : _registerUser(email, password, username);
    }
  }

  Future<void> _loginUser(String email, String password) async {
    try {
      await _authInstance.signInWithEmailAndPassword(
          email: email, password: password);
      ref.read(indexProvider.notifier).state = 0;
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isProcessing = false;
      });
      if (!mounted) return;
      handleFireBaseError(e.code, context);
      return;
    }
  }

  Future<void> _registerUser(
      String email, String password, String username) async {
    try {
      final userData = await _authInstance.createUserWithEmailAndPassword(
          email: email, password: password);
      ref.read(indexProvider.notifier).state = 0;
      await userData.user!.updateDisplayName(username);
      await _authInstance.currentUser!.reload();
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isProcessing = false;
      });
      if (!mounted) return;
      handleFireBaseError(e.code, context);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
          width: height > width ? width : width / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
                child: Text(
                  _isLogin ? noAccount : haveAccount,
                  overflow: TextOverflow.visible,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Card(
                  color: Theme.of(context).colorScheme.onTertiary,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!_isLogin)
                            BaseTextfield(
                              hint: username,
                              validator: basicValidator,
                              controller: _usernameController,
                            ),
                          BaseTextfield(
                            hint: "E-mail",
                            isEmail: true,
                            validator: emailValidator,
                            controller: _emailController,
                          ),
                          _isLogin
                              ? BaseTextfield(
                                  hint: password,
                                  isPassword: true,
                                  validator: basicValidator,
                                  controller: _passwordController,
                                )
                              : Column(
                                  children: [
                                    BaseTextfield(
                                      hint: password,
                                      isPassword: true,
                                      validator: registerPasswordValidator(
                                          _confirmPasswordController),
                                      controller: _passwordController,
                                    ),
                                    BaseTextfield(
                                      hint: confirmPassword,
                                      isPassword: true,
                                      validator: registerPasswordValidator(
                                          _passwordController),
                                      controller: _confirmPasswordController,
                                    ),
                                  ],
                                ),
                          const SizedBox(
                            height: 8,
                          ),
                          if (_isLogin)
                            ExcludeFocus(
                              child: TextButton(
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const AuthResetPopup(),
                                  );
                                },
                                child: const Text(
                                  passwordReset,
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  )),
              const SizedBox(
                height: 8,
              ),
              _isProcessing
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: MainButton(
                        onPressed: _validate,
                        text: _isLogin ? login : register,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
