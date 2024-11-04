import 'package:flutter/material.dart';
import 'package:remember/helpers/validators.dart';

class AuthTextfield extends StatefulWidget {
  const AuthTextfield({
    this.isEmail = false,
    this.isPassword = false,
    required this.hint,
    super.key,
  });

  final bool isEmail;
  final bool isPassword;
  final String hint;

  @override
  State<AuthTextfield> createState() => _AuthTextfieldState();
}

class _AuthTextfieldState extends State<AuthTextfield> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  bool hidden = true;
  @override
  Widget build(BuildContext context) {
    final validator = widget.isEmail
        ? emailValidator
        : widget.isPassword
            ? registerPasswordValidator
            : usernameValidator;
    return TextFormField(
      decoration: InputDecoration(
        label: Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Text(
            widget.hint,
          ),
        ),
        filled: true,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: widget.isPassword
            ? ExcludeFocus(
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      hidden = !hidden;
                    });
                  },
                  icon: hidden
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
              )
            : null,
      ),
      textInputAction: TextInputAction.next,
      obscureText: widget.isPassword ? hidden : false,
      focusNode: focusNode,
      validator: validator,
      onTapOutside: (event) {
        focusNode.unfocus();
      },
    );
  }
}
