import 'package:flutter/material.dart';
import 'package:remember/helpers/theme.dart';

class BaseTextfield extends StatefulWidget {
  const BaseTextfield({
    this.isEmail = false,
    this.isPassword = false,
    this.isTitle = false,
    required this.validator,
    required this.hint,
    required this.controller,
    this.inputAction = TextInputAction.next,
    super.key,
  });

  final bool isEmail;
  final bool isPassword;
  final bool isTitle;
  final String hint;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final TextInputAction inputAction;

  @override
  State<BaseTextfield> createState() => _BaseTextfieldState();
}

class _BaseTextfieldState extends State<BaseTextfield> {
  late FocusNode _focusNode;
  bool _hidden = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        textCapitalization: widget.isTitle
            ? TextCapitalization.sentences
            : TextCapitalization.none,
        keyboardType: widget.isEmail ? TextInputType.emailAddress : null,
        controller: widget.controller,
        textInputAction: widget.inputAction,
        obscureText: widget.isPassword ? _hidden : false,
        focusNode: _focusNode,
        validator: widget.validator,
        onTapOutside: (event) {
          _focusNode.unfocus();
        },
        decoration: InputDecoration(
          errorStyle: const TextStyle(color: Colors.red),
          errorBorder: getTextFieldBorder(color: Colors.red),
          filled: true,
          hintText: widget.hint,
          suffixIcon: widget.isPassword
              ? ExcludeFocus(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _hidden = !_hidden;
                      });
                    },
                    icon:
                        Icon(_hidden ? Icons.visibility_off : Icons.visibility),
                  ),
                )
              : null,
          enabledBorder: getTextFieldBorder(),
          focusedBorder: getTextFieldBorder(),
          border: getTextFieldBorder(),
        ),
      ),
    );
  }
}
