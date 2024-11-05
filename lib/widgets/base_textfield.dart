import 'package:flutter/material.dart';
import 'package:remember/helpers/constants.dart';

class BaseTextfield extends StatefulWidget {
  const BaseTextfield({
    this.isEmail = false,
    this.isPassword = false,
    required this.validator,
    required this.label,
    required this.controller,
    super.key,
  });

  final bool isEmail;
  final bool isPassword;
  final String label;
  final String? Function(String?) validator;
  final TextEditingController controller;

  @override
  State<BaseTextfield> createState() => _BaseTextfieldState();
}

class _BaseTextfieldState extends State<BaseTextfield> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  bool hidden = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.emailAddress,
        controller: widget.controller,
        textInputAction: TextInputAction.next,
        obscureText: widget.isPassword ? hidden : false,
        obscuringCharacter: "●",
        focusNode: focusNode,
        validator: widget.validator,
        onTapOutside: (event) {
          focusNode.unfocus();
        },
        decoration: InputDecoration(
          filled: true,
          label: Center(
            child: Text(widget.label),
          ),
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
          enabledBorder: textFieldBorder,
          focusedBorder: textFieldBorder,
        ),
      ),
    );
  }
}
