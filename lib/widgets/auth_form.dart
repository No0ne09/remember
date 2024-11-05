import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:remember/helpers/validators.dart';
import 'package:remember/widgets/auth_textfield.dart';
import 'package:remember/widgets/email_reset_popup.dart';
import 'package:remember/widgets/info_popup.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLogin = true;
  bool _isProccesing = false;
  final _firebase = FirebaseAuth.instance;
  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleAuthError(FirebaseAuthException e) async {
    String message;
    switch (e.code) {
      case 'invalid-credential':
        message = "Upewnij się, że dane są poprawne.";
      case 'network-request-failed':
        message = "Upewnij się, posiadasz połączenie z internetem.";
      case 'email-already-in-use':
        message = "Istnieje już konto powiązane z tym adresem email.";
      case 'invalid-email':
        message = "Upewnij się, podany adres email jest poprawny.";
      default:
        message = "Wystąpił nieznany błąd.";
    }
    await showDialog(
      context: context,
      builder: (context) => InfoPopup(title: "Uwaga", desc: message),
    );
  }

  Future<void> _validate() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isProccesing = true;
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
      await _firebase.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isProccesing = false;
      });
      _handleAuthError(e);
      return;
    }
  }

  Future<void> _registerUser(
      String email, String password, String username) async {
    try {
      final userData = await _firebase.createUserWithEmailAndPassword(
          email: email, password: password);

      await FirebaseFirestore.instance
          .collection("users")
          .doc(userData.user!.uid)
          .set({
        'username': username,
        'email': email,
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isProccesing = false;
      });
      _handleAuthError(e);
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
                    _emailController.clear();
                    _usernameController.clear();
                    _passwordController.clear();
                    _confirmPasswordController.clear();
                  });
                },
                child: Text(
                  _isLogin ? "Nie masz jeszcze konta?" : "Masz już konto?",
                  overflow: TextOverflow.visible,
                ),
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
                            AuthTextfield(
                              hint: "Nazwa użytkownika",
                              validator: basicValidator,
                              controller: _usernameController,
                            ),
                          AuthTextfield(
                            hint: "Adres email",
                            isEmail: true,
                            validator: emailValidator,
                            controller: _emailController,
                          ),
                          _isLogin
                              ? AuthTextfield(
                                  hint: "Hasło",
                                  isPassword: true,
                                  validator: basicValidator,
                                  controller: _passwordController,
                                )
                              : Column(
                                  children: [
                                    AuthTextfield(
                                      hint: "Hasło",
                                      isPassword: true,
                                      validator: registerPasswordValidator(
                                          _confirmPasswordController),
                                      controller: _passwordController,
                                    ),
                                    AuthTextfield(
                                      hint: "Powtórz Hasło",
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
                                        const EmailResetPopup(),
                                  );
                                },
                                child: const Text(
                                  "Nie pamiętam hasła",
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
              _isProccesing
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _validate,
                        child:
                            Text(_isLogin ? "Zaloguj się" : "Zarejestruj się"),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
