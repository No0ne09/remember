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
      if (e.code == 'invalid-credential') {
        if (!mounted) {
          return;
        }
        await showDialog(
          context: context,
          builder: (context) => const InfoPopup(
              title: "Uwaga", desc: "Upewnij się, że dane są poprawne."),
        );

        return;
      }
      if (e.code == "network-request-failed") {
        if (!mounted) {
          return;
        }
        await showDialog(
          context: context,
          builder: (context) => const InfoPopup(
              title: "Uwaga",
              desc: "Upewnij się, posiadasz połączenie z internetem."),
        );

        return;
      }
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
      if (e.code == "network-request-failed") {
        if (!mounted) {
          return;
        }
        await showDialog(
          context: context,
          builder: (context) => const InfoPopup(
              title: "Uwaga",
              desc: "Upewnij się, posiadasz połączenie z internetem."),
        );

        return;
      }
      if (e.code == 'email-already-in-use') {
        if (!mounted) {
          return;
        }
        await showDialog(
          context: context,
          builder: (context) => const InfoPopup(
              title: "Uwaga",
              desc: "Istnieje już konto powiązane z tym adresem email"),
        );

        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).colorScheme.onTertiary,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: 300,
                    child: Image.asset("assets/logo.png"),
                  ),
                  if (!_isLogin)
                    AuthTextfield(
                      hint: "Nazwa użytkownika",
                      validator: usernameValidator,
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
                          validator: usernameValidator,
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
                  _isProccesing
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            ElevatedButton(
                              onPressed: _validate,
                              child: Text(
                                  _isLogin ? "Zaloguj się" : "Zarejestruj się"),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            if (_isLogin)
                              Column(
                                children: [
                                  TextButton(
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
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(_isLogin
                                  ? "Utwórz nowe konto"
                                  : "Mam już konto"),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ));
  }
}
