import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remember/helpers/functions.dart';
import 'package:remember/helpers/validators.dart';
import 'package:remember/widgets/auth_textfield.dart';
import 'package:remember/widgets/info_popup.dart';

class EmailResetPopup extends StatefulWidget {
  const EmailResetPopup({super.key});

  @override
  State<EmailResetPopup> createState() => _EmailResetPopupState();
}

class _EmailResetPopupState extends State<EmailResetPopup> {
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
          setState(() {
            _isLoading = false;
          });
          return;
        }
      }
      if (!mounted) {
        return;
      }
      showToast("Sprawdź swoją skrzynkę");
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
            Row(
              children: [
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const CircleAvatar(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      child: Icon(Icons.close),
                    ))
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
                AuthTextfield(
                  validator: emailValidator,
                  hint: "E-mail",
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 10,
                ),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _resetPassword,
                        child: const Text("Wyślij wiadomość"),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
