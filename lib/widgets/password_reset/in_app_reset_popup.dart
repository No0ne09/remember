import 'package:flutter/material.dart';
import 'package:remember/helpers/validators.dart';
import 'package:remember/widgets/buttons/exit_button.dart';
import 'package:remember/widgets/buttons/main_button.dart';
import 'package:remember/widgets/textfields/base_textfield.dart';

class InAppResetPopup extends StatefulWidget {
  const InAppResetPopup({super.key});

  @override
  State<InAppResetPopup> createState() => _InAppResetPopupState();
}

class _InAppResetPopupState extends State<InAppResetPopup> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
                MainButton(text: "Zresetuj hasło", onPressed: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
